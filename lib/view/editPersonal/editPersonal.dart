import 'dart:io';
import 'dart:ui';

import 'package:fixtures/Localizations/AppGlobalCupertinoLocalizationsDelegate.dart';
import 'package:fixtures/config.dart';
import 'package:fixtures/model/AreaModel.dart';
import 'package:fixtures/model/PersonalModel.dart';
import 'package:fixtures/service/api/FileApi.dart';
import 'package:fixtures/service/api/UserApi.dart';
import 'package:fixtures/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'idCard.dart';

class EditPersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditPersonalPageState();
}

class _EditPersonalPageState extends State<EditPersonalPage>
    with FileMixin, UserApi {
  Future<XFile?>? _imagePath;

  var _image;

  var _imageSource;
  var _idCardController = TextEditingController();
  var _phoneController = TextEditingController();
  var _nameController = TextEditingController();
  var _birthDayController = TextEditingController();
  var _nickNameController = TextEditingController();
  var _selectValue = TextEditingController(text: "身份证");
  var _localTextController = TextEditingController();
  var positions = <String>["身份证", "护照"];
  bool _isSelect = false;
  List<AreaModel> locals = [
    AreaModel(
        111, "广东", [AreaModel(1222, "惠州", null), AreaModel(1333, "广州", null)]),
    AreaModel(111, "广东111",
        [AreaModel(1222, "惠州111", null), AreaModel(1333, "广州222", null)]),
  ];

  List<AreaModel> subLocalList = [];

  var localName = "";

  var subLocalName = "";

  int localIndex = 0;

  int subLocalIndex = 0;

  var sex = false;

  String pic = "";

  void getMyInfo() {
    getPersonal(successCallBack: (data) {
      setState(() {
        var user = data["user"];
        _nickNameController.text = user["nickName"];
        pic = user["pic"];
        sex = user["sex"] == 1 ? false : true;
        String birthday = user["birthday"];
        _birthDayController.text = birthday;
        subLocalList = locals[1].children!;
        _localTextController.text = user["location"];
        print(subLocalList);
      });
    }, errorCallBack: (code, msg) {
      print(msg);
    });
  }

  void saveMyInfo() {
    var pmodel = PersonalModel(
        nickName: _nickNameController.text,
        headPortrait: pic,
        sex: sex ? 2 : 1,
        birthday: _birthDayController.text,
        location: _localTextController.text
    );
    savePersonal(
      params: pmodel,
      successCallBack: (data) {
        setState(() {
          getMyInfo();
        });
      }, errorCallBack: (code, msg) {
      print(msg);
    },);
  }


  @override
  void initState() {
    super.initState();
    getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: '返回',
          middle: Text("编辑个人资料"),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: ListView(
          children: [
            _head(),
            _infoGrid(),
          ],
        ));
  }

  void UploadFiles(file) async {
    postFile(
        file: file,
        successCallBack: (data) {
          pic = "/"+data["full_path"];
          saveMyInfo();
        },
        errorCallBack: (int code, String msg) {
          openMsg(msg);
        });
  }

  void openMsg(String msg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text(msg),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确认'),
                onPressed: () {
                  Navigator.of(context).pop("ok");
                },
              ),
            ],
          );
        });
  }
  void _showSheetDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text('选择来源'),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              child: Text("取消")),
          actions: [
            CupertinoActionSheetAction(
                onPressed: () {
                  _imageSource = ImageSource.camera;
                  _selectedImage();
                  Navigator.of(context).pop();
                },
                child: Text("拍照")),
            CupertinoActionSheetAction(
                onPressed: () {
                  _imageSource = ImageSource.gallery;
                  _selectedImage();
                  Navigator.of(context).pop();
                },
                child: Text("相册"))
          ],
        );
      },
    );
  }

  void _selectedImage() {
    Future<XFile?> image = ImagePicker().pickImage(source: _imageSource);
    setState(() {
      _imagePath = image;
    });
  }

  void _showTypePick() {
    var i = 0;
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text("选择证件类型"),
          actions: [
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
                setState(() {
                  _isSelect = !_isSelect;
                  _selectValue.text = positions[i];
                });
                Navigator.of(context).pop();
              },
            )
          ],
          content: Container(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (int value) {
                i = value;
                setState(() {
                  _selectValue.text = positions[i];
                });
              },
              children: positions.map((e) => Text(e)).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _previewImage() {
    return FutureBuilder<XFile?>(
      future: _imagePath,
      builder: (context, AsyncSnapshot<XFile?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _image = snapshot.data;
          UploadFiles(File(snapshot.data!.path));
          return CircleAvatar(
              radius: 40,
              backgroundImage: FileImage(File(snapshot.data!.path)));
        } else {
          return CircleAvatar(

            backgroundImage: NetworkImage(Config.BASE_URL + pic),
            radius: 40,
          );
        }
      },
    );
  }

  Widget _head() {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        Form.of(primaryFocus!.context!)?.save();
      },
      child: CupertinoFormSection.insetGrouped(
          margin: EdgeInsets.symmetric(horizontal: gutter, vertical: gutterV),
          children: [
            CupertinoFormRow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("更改头像"),
                  GestureDetector(
                    onTap: () {
                      _showSheetDialog();
                    },
                    child: _previewImage(),
                  ),
                ],
              ),
            ),
            CupertinoTextFormFieldRow(
              style: TextStyle(height: 1.4),
              controller: _nickNameController,
              prefix: Text("昵称"),
              textAlign: TextAlign.end,
              placeholder: '请输入昵称',
              onChanged: (v) {
                saveMyInfo();
              },
              textInputAction: TextInputAction.next,
            ),
            CupertinoTextFormFieldRow(
              style: TextStyle(height: 1.4),
              prefix: Text("所在位置"),
              textAlign: TextAlign.end,
              placeholder: "所在位置",
              readOnly: true,
              controller: _localTextController,
              onTap: () {
                _showLocalPick(context);
              },
              textInputAction: TextInputAction.next,
            ),
            CupertinoFormRow(
              prefix: Text("性别"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("男"),
                  CupertinoSwitch(
                    value: sex,
                    activeColor: Colors.pinkAccent,
                    trackColor: Colors.blueAccent,
                    thumbColor:
                    sex ? Colors.pink.shade700 : Colors.blue.shade700,
                    onChanged: (bool value) {
                      setState(() {
                        sex = value;
                      });
                      saveMyInfo();
                    },
                  ),
                  Text("女"),
                ],
              ),
            ),
            CupertinoTextFormFieldRow(
              style: TextStyle(height: 1.4),
              prefix: Text("生日"),
              textAlign: TextAlign.end,
              placeholder: "生日",
              controller: _birthDayController,
              readOnly: true,
              onTap: () {
                _showDatePicker();
                saveMyInfo();
              },
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
            ),
          ]),
    );
  }

  double get gutterV => 4;

  static final double gutter = 8;

  void _showLocalPick(context) {
    var _localController = FixedExtentScrollController(initialItem: localIndex);

    var _subLocalController =
    FixedExtentScrollController(initialItem: subLocalIndex);
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  _modalActions(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 80,
                          width: 100,
                          child: CupertinoPicker(
                            itemExtent: 48,
                            scrollController: _localController,
                            onSelectedItemChanged: (int value) {
                              state(() {
                                subLocalList = locals[value].children!;
                                localIndex = value;
                                _localTextController.text =
                                    locals[value].name! + subLocalName;
                                _subLocalController.animateTo(0.0,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.easeInOut);
                              });
                            },
                            children: createEachItem(locals),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 80,
                          width: 100,
                          child: CupertinoPicker(
                            itemExtent: 48,
                            scrollController: _subLocalController,
                            onSelectedItemChanged: (int value) {
                              state(() {
                                subLocalName =
                                locals[localIndex].children![value].name!;

                                print(subLocalName);

                                subLocalIndex = value;
                                _localTextController.text =
                                    locals[localIndex].name! + subLocalName;
                                saveMyInfo();
                              });
                            },
                            children: createEachItem(subLocalList),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> createEachItem(List<AreaModel> data) {
    List<Widget> target = [];

    for (AreaModel item in data) {
      target.add(Container(
        padding: EdgeInsets.only(top: 14.0, bottom: 10.0),
        child: Text(
          item.name ?? '',
          style: TextStyle(fontSize: 14.0),
        ),
      ));
      print(item.name);
    }

    return target;
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) =>
          Container(
            color: Colors.white,
            height: 300,
            child: Container(
              child: Column(
                children: [
                  _modalActions(),
                  Container(
                    height: 200,
                    child: Localizations.override(
                      context: context,
                      delegates: [AppGlobalCupertinoLocalizationsDelegate()],
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (dateTime) {
                            setState(() {
                              this._birthDayController.text =
                                  dataBirthFormat(dateTime);
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _infoGrid() {
    double padding = 8;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: gutter, vertical: gutterV),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(gutter),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        previousPageTitle: "返回",
                        middle: Text("实名认证"),
                      ),
                      child: ListView(
                        children: [
                          Form(
                            autovalidateMode: AutovalidateMode.always,
                            onChanged: () {
                              Form.of(primaryFocus!.context!)?.save();
                            },
                            child: CupertinoFormSection.insetGrouped(
                                margin: EdgeInsets.symmetric(
                                    horizontal: gutter, vertical: gutterV),
                                children: [
                                  _formCell(
                                      title: '姓名',
                                      controller: _nameController,
                                      placeholder: '请输入真实姓名'),
                                  _formCell(
                                      title: '手机号',
                                      controller: _phoneController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 16,
                                      placeholder: '请输入手机号'),
                                  CupertinoTextFormFieldRow(
                                    style: TextStyle(height: 1.4),
                                    prefix: Text("证件类型"),
                                    textAlign: TextAlign.end,
                                    placeholder: "身份证",
                                    controller: _selectValue,
                                    readOnly: true,
                                    onTap: () {
                                      _showTypePick();
                                    },
                                    keyboardType: TextInputType.datetime,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  _formCell(
                                      title: "证件号",
                                      controller: _idCardController,
                                      maxLength: 18,
                                      regExp: r'[0-9|X|x]',
                                      placeholder: '请输入证件号'),
                                ]),
                          ),
                          _btnWidget(),
                        ],
                      ),
                    );
                  },
                ));
              },
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidAddressCard,
                      size: 30,
                      color: Colors.green,
                    ),
                    Text("实名认证")
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              style: mainButtonStyle(),
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.video,
                        size: 30, color: Colors.orange),
                    Text("人脸识别"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _btnWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'toNext',
            child: CupertinoButton.filled(child: Text("下一步"), onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return IdCardPageState();
              }));
            }),
          ),
        ],
      ),
    );
  }

  Widget _modalActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: TextStyle(color: Colors.red),
            )),
        CupertinoButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "确定",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  CupertinoTextFormFieldRow _formCell({required String title,
    required TextEditingController controller,
    String? placeholder,
    bool? readOnly,
    TextInputType? keyboardType,
    int? maxLength,
    String? regExp,
    bool? isDone}) {
    var inputFormatters = <TextInputFormatter>[];
    if (maxLength != null) {
      inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
    }
    if (regExp != null) {
      inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(regExp)));
    }

    return CupertinoTextFormFieldRow(
      readOnly: readOnly == true,
      style: TextStyle(height: 1.4),
      controller: controller,
      prefix: Text(title),
      inputFormatters: inputFormatters,
      textAlign: TextAlign.end,
      keyboardType: keyboardType,
      placeholder: placeholder,
      textInputAction:
      isDone == true ? TextInputAction.done : TextInputAction.next,
    );
  }
}

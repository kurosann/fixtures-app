import 'dart:io';
import 'dart:ui';

import 'package:fixtures/Localizations/AppGlobalCupertinoLocalizationsDelegate.dart';
import 'package:fixtures/model/AreaModel.dart';
import 'package:fixtures/service/api/FileApi.dart';
import 'package:fixtures/service/api/MyInfoApi.dart';
import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../config.dart';

class EditPersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditPersonalPageState();
}

class _EditPersonalPageState extends State<EditPersonalPage>
    with FileMixin, PersonalMixin {
  Future<XFile?>? _imagePath;

  var _image;

  var _imageSource;

  var _birthDayController = TextEditingController();
  var _nickNameController = TextEditingController();

  var _localTextController = TextEditingController();

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

  bool _isShowPick = false;
  int rid = 1;
  String balance = "0.0";
  String age = "0";
  String invitationCode = "000000";
  String nickName = "";
  String phone = "";
  String pic = "";
  String sexStr = "";
  String uName = "";
  String vipStr = "";
  String rolesStr = "";
  String birthday = "";
  double services = 0.0;
  double crafts = 0.0;
  static const int APPBAR_SCROLL_OFFSET = 50;

  double alphaAppBar = 0;

  void getMyInfo() {
     getPersonal(successCallBack: (data) {
       setState(() {
      var user = data["user"];
      var wallet = data["wallet"];
      var master = data["master"];
      services = double.parse(master["services"]);
      crafts = double.parse(master["crafts"]);
      balance = wallet["walletBalance"].toString();
      age = user["age"].toString();
      invitationCode = user["invitationCode"];
      _nickNameController.text = user["nickName"];
      phone = user["phone"];
      pic = user["pic"];
      sexStr = user["sexStr"];
      sex = user["sex"] == 1 ?false:true;
      uName = user["uName"];
      rid = user["rid"];
      vipStr = user["vipStr"];
      rolesStr = user["rolesStr"];
      birthday = user["birthday"];
      _birthDayController.text = birthday;
      subLocalList = locals[1].children!;
      _localTextController.text ="广东深圳";
      print(subLocalList);
       });
    }, errorCallBack: (code, msg) {
      print(msg);
    });
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
          middle: Text("编辑个人资料"),
        ),
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
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
//          success
        },
        errorCallBack: (int code, String msg) {
//          error
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
            backgroundImage: NetworkImage(Config.BASE_URL+pic),
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
              placeholder: nickName,
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
      builder: (context) => Container(
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
                          previousPageTitle: "编辑个人资料",
                          middle: Text("实名认证"),
                        ),
                        child: ListView(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              child: Image(
                                  image: NetworkImage(
                                      "https://bkimg.cdn.bcebos.com/pic/0eb30f2442a7d933b0a8b30ca24bd11373f00148?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto")),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              child: Image(
                                  image: NetworkImage(
                                      "https://bkimg.cdn.bcebos.com/pic/0eb30f2442a7d933b0a8b30ca24bd11373f00148?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto")),
                            ),
                          ],
                        ));
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
}

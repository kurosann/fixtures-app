import 'dart:io';
import 'dart:ui';

import 'package:fixtures/Localizations/AppGlobalCupertinoLocalizationsDelegate.dart';
import 'package:fixtures/config.dart';
import 'package:fixtures/model/AreaModel.dart';
import 'package:fixtures/service/api/FileApi.dart';
import 'package:fixtures/service/api/UserApi.dart';
import 'package:fixtures/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class IdCardPageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPageState>
    with FileMixin, UserApi {
  Future<XFile?>? _imagePath;

  var _image;

  var _imageSource;

  var _birthDayController = TextEditingController();
  var _nickNameController = TextEditingController();

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
        _localTextController.text = "广东深圳";
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
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: ListView(
          children: [
            _head(),
            _btnWidget(),
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
          return Image(
              width: 100,
              height: 100,
              image: FileImage(File(snapshot.data!.path)));
        } else {
          return Image(
            width: 100,
            height:100,
            image: NetworkImage("https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
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
                  Text("身份证A面"),
                  GestureDetector(
                    onTap: () {
                      _showSheetDialog();
                    },
                    child: _previewImage(),
                  ),
                ],
              ),
            ),
            CupertinoFormRow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("身份证B面"),
                  GestureDetector(
                    onTap: () {
                      _showSheetDialog();
                    },
                    child: _previewImage(),
                  ),
                ],
              ),
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

  Widget _btnWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'toNext',
            child: CupertinoButton.filled(child: Text("提交审核"), onPressed: () {}),
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

  CupertinoTextFormFieldRow _formCell(
      {required String title,
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

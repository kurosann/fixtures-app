import 'dart:io';
import 'dart:ui';

import 'package:face_net_authentication/httpApi/updateFace.dart';
import 'package:face_net_authentication/pages/home.dart';
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

import 'facePage.dart';

class IdCardPageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IdCardPageState();

}

class _IdCardPageState extends State<IdCardPageState>
    with FileMixin, UserApi, FaceMixin {
  Future<XFile?>? _imagePathA;
  Future<XFile?>? _imagePathB;
  int isA = 0;
  String? idCardAUrl="https://bkimg.cdn.bcebos.com/pic/0eb30f2442a7d933b0a8b30ca24bd11373f00148?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto";
  String? idCardBUrl="https://bkimg.cdn.bcebos.com/pic/0eb30f2442a7d933b0a8b30ca24bd11373f00148?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2U5Mg==,g_7,xp_5,yp_5/format,f_auto";
  var _imageA;
  var _imageB;
  var _imageSource;
  var _birthDayController = TextEditingController();
  var _nickNameController = TextEditingController();
  var next = false;
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

  String pic = "";

  void _getRealInfo() {
    getRealInfo(successCallBack: (data) {
      setState(() {
        print(data["pass"]);
        if(data["pass"] != 1){
          idCardAUrl = Config.BASE_URL + data["idCardAUrl"];
          idCardBUrl = Config.BASE_URL + data["idCardBUrl"];
        }
      });
    }, errorCallBack: (code, msg) {
      openMsg(msg);
    });
  }
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
    _getRealInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("上传身份证"),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: ListView(
          children: [
            _head(),
            _btnWidget(),
          ],
        ));
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

  Future<bool> postFaceUrl() async {
    await postFace(
        params: {"idCardAUrl": idCardAUrl, "idCardBUrl": idCardBUrl},
        successCallBack: (data) {
          setState(() {
            next = true;
          });
        },
        errorCallBack: (int code, String msg) {
          openMsg(msg);
        });
    return next;
  }

  void UploadFiles(file, int v) async {
    postFile(
        file: file,
        params: {"type": "1", "domain": "idCards"},
        successCallBack: (data) {
//          success
        print(data.toString());
          if (v == 1) {
            idCardAUrl = data["full_path"];
          } else {
            idCardBUrl = data["full_path"];
          }
        },
        errorCallBack: (int code, String msg) {
//          error
          openMsg(msg);
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
      print(isA);
      if (isA == 1) {
        _imagePathA = image;
      }
      if (isA == 2) {
        _imagePathB = image;
      }
    });
  }

  Widget _previewImageA() {
    return FutureBuilder<XFile?>(
      future: _imagePathA,
      builder: (context, AsyncSnapshot<XFile?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _imageA = snapshot.data;
          UploadFiles(File(snapshot.data!.path), 1);
          return Image(
              width: 100, height: 100, image: FileImage(File(_imageA!.path)));
        } else {
          return Image(
            width: 100,
            height: 100,
            image: NetworkImage(idCardAUrl!)
          );
        }
      },
    );
  }

  Widget _previewImageB() {
    return FutureBuilder<XFile?>(
      future: _imagePathB,
      builder: (context, AsyncSnapshot<XFile?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _imageB = snapshot.data;
          UploadFiles(File(snapshot.data!.path), 2);
          return Image(
              width: 100, height: 100, image: FileImage(File(_imageB!.path)));
        } else {
          return Image(
            width: 100,
            height: 100,
            image: NetworkImage(idCardBUrl!),
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
                      isA = 1;
                      _showSheetDialog();
                    },
                    child: _previewImageA(),
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
                      isA = 2;
                      _showSheetDialog();
                    },
                    child: _previewImageB(),
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
            child: CupertinoButton.filled(
                child: Text("下一步"),
                onPressed: () async {
                  await postFaceUrl();
                  if (next) {
                    Navigator.of(context, rootNavigator: true)
                        .push(CupertinoPageRoute(builder: (BuildContext context) {
                      return FacePageState();
                    }));
                  }
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

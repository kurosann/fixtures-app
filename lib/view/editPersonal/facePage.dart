import 'dart:io';
import 'dart:ui';

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

class FacePageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FacePageState();
}

class _FacePageState extends State<FacePageState> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("人脸识别"),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: FaceHomePage());
  }
}

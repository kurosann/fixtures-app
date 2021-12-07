import 'package:fixtures/view/findFixture/findFixture.dart';
import 'package:fixtures/view/findFixture/publish.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/setting/setting.dart';
import 'package:flutter/cupertino.dart';


var routes = {
  "/balance": (context) => Container(),
  "/home": (context) => HomePage(),
  "/setting": (context) => SettingPage(),
  "/findFixture": (context) => FindFixturePage(),
  "/findFixture/publish": (context) => PublishPage(),
};

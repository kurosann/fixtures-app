import 'package:fixtures/routes.dart';
import 'package:fixtures/view/findFixture/findFixture.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/rating/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: '小求',
      routes: routes,
      theme: CupertinoThemeData(
        barBackgroundColor: Colors.white,
      ),
      home: FindFixturePage(),
    );
  }
}

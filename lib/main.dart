import 'package:fixtures/routes.dart';
import 'package:fixtures/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:fluwx/fluwx.dart' as fluwx;

import 'config.dart';

void main() {
//  fluwx.registerWxApi(
//      appId: Config.WX_APP_ID,
//      universalLink: Config.WX_UNIVERSAL_Link);
  runApp(MyApp());
  ///初始化
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        DefaultCupertinoLocalizations.delegate,
      ],
      title: '小求',
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          barBackgroundColor: Color.fromARGB(150, 255, 255, 255),
          primaryColor: Colors.orange,
          brightness: Brightness.light),
      home: Login(),
    );
  }
}

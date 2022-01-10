import 'package:fixtures/Localizations/AppGlobalCupertinoLocalizationsDelegate.dart';
import 'package:fixtures/routes.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:face_net_authentication/pages/home.dart';
void main() {
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
      home: HomePage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

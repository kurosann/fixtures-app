import 'package:fixtures/Localizations/AppGlobalCupertinoLocalizationsDelegate.dart';
import 'package:fixtures/routes.dart';
import 'package:fixtures/view/editPersonal/editPersonal.dart';
import 'package:fixtures/view/faces/flutter_face_scan.dart';
import 'package:fixtures/view/faces/scanCameras.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(MyApp());
  ///初始化
  FaceScan.init();
}
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       localizationsDelegates: [
//         // ... app-specific localization delegate[s] here
//         DefaultCupertinoLocalizations.delegate,
//       ],
//       title: '小求',
//       routes: routes,
//       debugShowCheckedModeBanner: false,
//       theme: CupertinoThemeData(
//           barBackgroundColor: Color.fromARGB(150, 255, 255, 255),
//           primaryColor: Colors.orange,
//           brightness: Brightness.light),
//       home: HomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        DefaultCupertinoLocalizations.delegate,
      ],
      title: '人脸识别',
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          barBackgroundColor: Color.fromARGB(150, 255, 255, 255),
          primaryColor: Colors.orange,
          brightness: Brightness.light),
      home: ScanCamerasPage(title:"人脸识别"),
    );
  }
}

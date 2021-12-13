import 'package:fixtures/routes.dart';
import 'package:fixtures/view/costNeed/costNeed.dart';
import 'package:fixtures/view/faces/faceCamera.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/order/orderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_face_scan/flutter_face_scan.dart';

void main() {
  runApp(MyApp());
  ///初始化
  FaceScan.init();
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       title: '小求',
//       routes: routes,
//       debugShowCheckedModeBanner: false,
//       theme: CupertinoThemeData(
//           barBackgroundColor: Color.fromARGB(150, 255, 255, 255),
//           primaryColor: Colors.orange,
//           brightness: Brightness.light),
//       home: FaceCameraPage(title: '人脸识别',),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FaceCameraPage(title: 'Flutter Demo Home Page'),
    );
  }
}
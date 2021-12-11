import 'package:fixtures/routes.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/order/orderDetail.dart';
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
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          barBackgroundColor: Color.fromARGB(150, 255, 255, 255),
          primaryColor: Colors.orange,
          brightness: Brightness.light),
      home: OrderDetailPage(),
    );
  }
}

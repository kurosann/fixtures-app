import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_face_scan/flutter_face_scan.dart';


class FaceCameraPage extends StatefulWidget {
  FaceCameraPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FaceCameraPageState createState() => _FaceCameraPageState();
}

class _FaceCameraPageState extends State<FaceCameraPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                FaceScan.openScan(
                    context: context,
                    path: null,
                    faceScanCallBack: (path) {
                      print("返回图片文件路径：" + path);
                    });

                Timer(Duration(milliseconds: 5000), () {
                  ///通知图形界面在识别中
                  FaceScan.Scaning();
                });

                Timer(Duration(milliseconds: 10000), () {
                  ///通知图形界面识别失败
                  FaceScan.ScanFail();
                });

                Timer(Duration(milliseconds: 20000), () {
                  ///识别成功后可关闭
                  Navigator.pop(context);
                });
              },
              child: Text("开始识别"),
            )
          ],
        ),
      ),
    );
  }
}
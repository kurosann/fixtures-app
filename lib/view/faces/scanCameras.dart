import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_face_scan.dart';

class ScanCamerasPage extends StatefulWidget {
  ScanCamerasPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ScanCamerasPageState createState() => _ScanCamerasPageState();
}

class _ScanCamerasPageState extends State<ScanCamerasPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '上传人脸认证',
        middle: Text("上传人脸认证",
            style: TextStyle(fontSize: 21.0, color: Colors.black)),
      ),
      backgroundColor: Color.fromARGB(245, 245, 245, 245),
      child: CustomScrollView(slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {},
        ),
        SliverSafeArea(
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {
                  FaceScan.controller!.value.isIng = false;
                  FaceScan.openScan(
                      context: context,
                      path: null,
                      faceScanCallBack: (path) {
                        /// 在这里将本地图片上传
                        if (FaceScan.controller!.value.isSuccess) {
                          FaceScan.controller!.value.isSuccess = false;
                          print("返回图片文件路径：" + path);
                          // ///通知图形界面识别失败
                          // FaceScan.ScanFail();
                          Navigator.pop(context);
                        }
                      });
                },
                child: Text("开始识别"),
              ),
            ),
          ])),
        )
      ]),
    );
  }
}

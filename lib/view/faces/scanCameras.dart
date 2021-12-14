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
        middle:
            Text("上传人脸认证", style: TextStyle(fontSize: 21.0, color: Colors.black)),
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
                  FaceScan.openScan(
                      context: context,
                      path: null,
                      faceScanCallBack: (path) {

                        /// 在这里将本地图片上传
                        print("返回图片文件路径：" + path);
                      });

                  Timer(Duration(milliseconds: 5000), () {
                    ///通知图形界面在识别中
                    FaceScan.Scaning();
                  });

                  // Timer(Duration(milliseconds: 10000), () {
                  //   ///通知图形界面识别失败
                  //   FaceScan.ScanFail();
                  // });

                  Timer(Duration(milliseconds: 10000), () {
                    print("识别成功");
                    ///识别成功后可关闭
                    /// 在这里写人脸识别后的，返回上级
                    Navigator.pop(context);
                  });
                },
                child: Text("开始识别"),
              ),
            )
          ])),
        )
      ]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPhonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage> {
  String _phoneMenber = "1345****111";
  bool _isNext = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: '设置',
            middle: Text("修改手机号"),
          ),
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: CupertinoSliverRefreshControl(
                  onRefresh: () async {},
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        '当前正在使用的手机号为',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        _phoneMenber,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "修改后，您的账号信息不变",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: CupertinoButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue,
                          child: Text("立即修改"),
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

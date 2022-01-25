import 'package:fixtures/utils/utils.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: CustomScrollView(slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            largeTitle: Text("设置"),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              actionCell(
                  title: "修改密码",
                  tailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: CupertinoColors.inactiveGray,
                  ),
                  onPressed: () {
                    Navigator.of(allContext!).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        child: Container(),
                      );
                    }));
                  }),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 38),
                child: Divider(
                  height: 1.0,
                ),
              ),
              actionCell(
                  title: "关于页面",
                  tailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: CupertinoColors.inactiveGray,
                  ),
                  onPressed: () {
                    Navigator.of(allContext!).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        child: Container(),
                      );
                    }));
                  }),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 38),
                child: Divider(
                  height: 1.0,
                ),
              ),
              actionCell(
                  title: "退出登录",
                  tailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: CupertinoColors.inactiveGray,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false);
                  }),
            ]),
          )
        ]),
      ),
    );
  }
}

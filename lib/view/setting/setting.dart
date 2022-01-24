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
              ListTile(
                title: Text("修改密码"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Navigator.of(allContext!)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return CupertinoPageScaffold(
                      child: Container(),
                    );
                  }));
                },
              ),
              Divider(
                height: 1.0,
              ),
              ListTile(
                title: Text("关于页面"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Navigator.of(allContext!)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return CupertinoPageScaffold(
                      child: Container(),
                    );
                  }));
                },
              ),
              Divider(
                height: 1.0,
              ),
              ListTile(
                title: Text("退出登录"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                      Login()), (Route<dynamic> route) => false);

                  // Navigator.of(allContext!).pushAndRemoveUtil(CupertinoPageRoute(
                  //   builder: (context) {
                  //     return Login();
                  //   },
                  // ));
                },
              ),
            ]),
          )
        ]),
      ),
    );
  }
}

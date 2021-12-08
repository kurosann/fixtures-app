import 'package:fixtures/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text("设置"),
      ),
      child: ListView(
        children: [
          ListTile(
            title: Text("修改密码"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
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
                  .push(MaterialPageRoute(builder: (BuildContext context) {
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
              Navigator.of(allContext!)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  child: Container(),
                );
              }));
            },
          ),
        ],
      ),
    );
  }
}

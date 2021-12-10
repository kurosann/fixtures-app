import 'package:fixtures/view/login/phoneLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// 短信验证登录
Widget CodeLogin(BuildContext context) {
  return new Container(
    child: CupertinoButton(
      padding: EdgeInsets.all(0),
      child: Text(
        '短信验证码登录',
        style: TextStyle(fontSize: 12),
      ),
      onPressed: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) {
            return PhoneLogin();
          },
        ));
      },
    ),
  );
}

/// 密码登录
Widget PassworLogin(BuildContext context) {
  return new Container(
    child: TextButton(
      child: Text(
        '用账号密码登录',
        style: TextStyle(fontSize: 12),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}

void _showInfoDialog(context, String content) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(content),
        actions: [
          CupertinoDialogAction(
            child: Text("确定"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

/// 用户隐私
Widget UserInfo(BuildContext context, Widget widget) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        widget,
        Row(
          children: [
            Text('登陆即同意', style: TextStyle(fontSize: 12)),
            CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  '《用户隐私协议》',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  _showInfoDialog(context, '这是用户隐私协议');
                })
          ],
        ),
      ],
    ),
  );
}

/// 第三方登录
Widget OtherLogin() {
  return Padding(
    padding: EdgeInsets.only(top: 50),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(height: 1),
        ),
        new Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: new Text(
            "第三方登录",
            style: new TextStyle(
                fontSize: 12,
                color: Colors.black54),
          ),
        ),
        Expanded(
          child: Divider(height: 1),
        ),
      ],
    ),
  );
}

/// 第三方微信登录
Widget WeixinLogin() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 50,
          width: 100,
        ),
        new Container(
          padding: EdgeInsets.all(20),
          child: new GestureDetector(
            child: Icon(
              FontAwesomeIcons.weixin,
              size: 30,
              color: Color(0xff0e9324),
            ),
            onTap: () {
              // 填写方法
            },
          ),
        ),
        new Container(
          height: 50,
          width: 100,
        ),
      ],
    ),
  );
}

Widget ImageLogin(context) {
  return Container(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Image.asset(
            "assets/images/ss.png",
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    ),
  );
}

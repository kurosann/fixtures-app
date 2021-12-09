import 'dart:html';
import 'dart:js';

import 'package:fixtures/view/login/phoneLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';
import 'loginStyle.dart';

/// 短信验证登录
Widget CodeLogin(BuildContext context) {
  return new Container(
    child: TextButton(
      child: Text(
        '用短信验证码登录',
        style: TextStyle(fontSize: 12,color: Colors.lightBlue),
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
        style: TextStyle(fontSize: 12,color: Colors.lightBlue),
      ),
      onPressed: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) {
            return Login();
          },
        ));
      },
    ),
  );
}


/// 用户隐私
Widget UserInfo(BuildContext context,Widget widget) {
  void _showInfoDialog(String content) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Text(content),
            )
          ],
        );
      },
    );
  }
  return Padding(
      padding: EdgeInsets.only(left:20,bottom: 10),
      child: Row(
        children: <Widget>[
          widget,
          Spacer(),
          Text.rich(TextSpan(
              text: '登陆即同意',
              children: [
                TextSpan(
                  text: '《用户隐私协议》',
                  style: BlueStyle(),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _showInfoDialog('这是用户隐私协议'),
                ),
              ],
              style: BlackStyle())),
        ],
      ),
    );
}

/// 第三方登录
Widget OtherLogin() {
  return  Padding(
    padding: EdgeInsets.only(top: 50),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 1,
          width: 100,
          decoration: OtherBox(),
        ),
        new Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: new Text(
            "第三方登录",
            style: new TextStyle(fontWeight: FontWeight.w700,fontSize: 12, color: Colors.black54),
          ),
        ),
        new Container(
          height: 1,
          width: 100,
          decoration: OtherBox(),
        ),
      ],
    ),
  );
}

/// 第三方微信登录
Widget WeixinLogin() {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 50,
          width: 100,
        ),
        new Container(
          padding: EdgeInsets.all(20),
          child: new IconButton(
            iconSize: 30,
            icon: Icon(
              FontAwesomeIcons.weixin,
              size: 30,
              color: Color(0xff0e9324),
            ),
            onPressed: () {
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


Widget ImageLogin() {
  return Container(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Image.asset(
            "assets/images/ss.png",
            width: 90,
            height: 100,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    ),
  );
}
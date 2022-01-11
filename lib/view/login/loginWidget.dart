import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




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
    padding: EdgeInsets.only(top: 10),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Divider(height: 1,color:Colors.grey),
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
          child: Divider(height: 1,color:Colors.grey),
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
            height: 110,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    ),
  );
}

Widget myCupertinoAndIcon(bool isLogging){
  return isLogging ? CupertinoActivityIndicator() : Icon(Icons.arrow_forward);
}

Widget LoginHeard() {
  return Container(
      margin: const EdgeInsets.only(left: 18.0,top: 18),
      child: Text('请输入您的手机号码，登录或注册您的小求账号',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Color.fromARGB(255, 12, 12, 12)))
  ) ;
}
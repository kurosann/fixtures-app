import 'package:fixtures/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLogin createState() => new _PhoneLogin();
}

class _PhoneLogin extends State<PhoneLogin> {
  final TextStyle _blackStyle = const TextStyle(
    fontSize: 14,
    textBaseline: TextBaseline.alphabetic,
    color: Color(0xFF333333),
  );
  final TextStyle _blueStyle = const TextStyle(
    fontSize: 14,
    color: Colors.lightBlue,
  );

  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  final phoneText = TextEditingController();
  final phoneCode = TextEditingController();
  bool isShowPassWord = false;

  void login() {
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm!.validate()) {
      loginForm.save();
      print('userName: ' + phoneText.text + ' password: ' + phoneCode.text);
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {

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
    return new MaterialApp(
      title: '手机验证码登录界面',
      home: new Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: new Text(
                  '登录',
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 53, 53),
                      fontSize: 30.0),
                )),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                key: loginKey,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        controller: phoneText,
                        decoration: new InputDecoration(
                          labelText: '请输入手机号',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon: new IconButton(
                            icon: new Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: () {
                              phoneText.clear();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (phone) {
                          if (phone!.length == 0) {
                            return '请输入手机号';
                          }
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        controller: phoneCode,
                        decoration: new InputDecoration(
                            labelText: '请输入验证码',
                            labelStyle: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                            suffixIcon: new IconButton(
                              icon: new Icon(
                                isShowPassWord
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                              onPressed: showPassWord,
                            )),
                        obscureText: !isShowPassWord,
                      ),
                    ),
                    new Container(
                      height: 45.0,
                      margin: EdgeInsets.only(top: 40.0),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          onPressed: login,
                          color: Color.fromARGB(255, 238, 106, 17),
                          child: new Text(
                            '登录',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(45.0)),
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            child: FlatButton(
                              child: Text(
                                '密码登录',
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) {
                                    return Login();
                                  },
                                ));
                              },
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              '忘记密码?',
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: <Widget>[
                          Text.rich(TextSpan(
                              text: '登陆即同意',
                              children: [
                                TextSpan(
                                  text: '《用户隐私协议》',
                                  style: _blueStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _showInfoDialog('这是用户隐私协议'),
                                ),
                              ],
                              style: _blackStyle)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
//                          mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            height: 1,
                            width: 100,
                            decoration: BoxDecoration(
                                gradient: new LinearGradient(colors: [
                              Colors.black54,
                              Colors.black54,
                            ])),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: new Text(
                              "第三方登录",
                              style: new TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          new Container(
                            height: 1,
                            width: 100,
                            decoration: BoxDecoration(
                                gradient: new LinearGradient(colors: [
                              Colors.black54,
                              Colors.black54,
                            ])),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(top: 30),
                            child: new IconButton(
                              icon: Icon(
                                FontAwesomeIcons.weixin,
                                color: Color(0xff0e9324),
                              ),
                              onPressed: () {
                                // 填写方法
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




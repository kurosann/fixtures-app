import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String userName;
  String password;
  bool isShowPassWord = false;
  final TextStyle _blackStyle = const TextStyle(
    fontSize: 14,
    textBaseline: TextBaseline.alphabetic,
    color: Color(0xFF333333),
  );

  void login() {
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      loginForm.save();
      print('userName: ' + userName + ' password: ' + password);
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Form表单示例',
      home: new Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: new Text(
                  '登录',
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 53, 53), fontSize: 30.0),
                )),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                key: loginKey,
                autovalidate: true,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入手机号',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          // suffixIcon: new IconButton(
                          //   icon: new Icon(
                          //     Icons.close,
                          //     color: Color.fromARGB(255, 126, 126, 126),
                          //   ),
                          //   onPressed: () {

                          //   },
                          // ),
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          userName = value;
                        },
                        validator: (phone) {
                          if (phone.length == 0) {
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
                        decoration: new InputDecoration(
                            labelText: '请输入密码',
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
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                    ),
                    new Container(
                      height: 45.0,
                      margin: EdgeInsets.only(top: 40.0),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          onPressed: login,
                          color: Color.fromARGB(255, 61, 203, 128),
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
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                            child: FlatButton(
                              child: Text(
                                '注册账号?',
                                style: TextStyle(color: Colors.black54),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              '忘记密码?',
                              style: TextStyle(color: Colors.black54),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10),
                      child: new Row(
//                          mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(height: 1,
                            width: 100,
                            decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [ Colors.black54,
                                      Colors.black54,
                                    ])
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: new Text("第三方登录", style: new TextStyle(
                                fontSize: 16, color: Colors.black54),),),
                          new Container(height: 1,
                            width: 100,
                            decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [ Colors.black54,
                                      Colors.black54,
                                    ])
                            ),
                          ),
                        ],
                      ),),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.all(10),
                            child: new IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.weixin,
                                  color: Color(0xff0e9324),
                                ),
                                onPressed: null),
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

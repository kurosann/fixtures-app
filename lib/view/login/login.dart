import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginStyle.dart';
import 'loginWidget.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  final phoneText = TextEditingController();
  final password = TextEditingController();
  bool isShowPassWord = false;

  void login() {
    print('userName: ' + phoneText.text + ' password: ' + password.text);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ImageLogin(),
          Form(
            onChanged: () {
              Form.of(primaryFocus!.context!)?.save();
            },
            child: CupertinoFormSection.insetGrouped(
              margin: EdgeInsets.all(20),
              header: LoginHeard(),
              footer: UserInfo(context, CodeLogin(context)),
              children: <Widget>[
                CupertinoTextField(
                  controller: phoneText,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  placeholderStyle: PhoneTextStyle(),
                  decoration: TextFieldBoxStyle(),
                  prefix: Padding(
                    padding: EdgeInsets.all(11),
                    child: new Icon(
                      Icons.person,
                      size: 26,
                      color: Color.fromARGB(255, 126, 126, 126),
                    ),
                  ),
                  prefixMode: OverlayVisibilityMode.always,
                  placeholder: '请输入手机号',
                  cursorColor: Color.fromARGB(255, 126, 126, 126),
                  keyboardType: TextInputType.phone,
                  suffixMode: OverlayVisibilityMode.editing,
                  suffix: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: new GestureDetector(
                        child: UserClose(),
                        onTap: () {
                          phoneText.clear();
                        },
                      ),
                    ),
                  ),
                ),
                CupertinoTextField(
                  controller: password,
                  placeholderStyle: PhoneTextStyle(),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: TextFieldBoxStyle(),
                  prefix: Padding(
                    padding: EdgeInsets.all(12),
                    child: new Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 126, 126, 126),
                    ),
                  ),
                  placeholder: '请输入密码',
                  cursorColor: Color.fromARGB(255, 126, 126, 126),
                  keyboardType: TextInputType.visiblePassword,
                  suffixMode: OverlayVisibilityMode.editing,
                  suffix: Padding(
                    padding: const EdgeInsets.all(12),
                    child: new GestureDetector(
                      child: new Icon(
                        isShowPassWord
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 126, 126, 126),
                      ),
                      onTap: () {
                        setState(() {
                          isShowPassWord = !isShowPassWord;
                        });
                      },
                    ),
                  ),
                  obscureText: !isShowPassWord,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 200, 200, 200),
                  blurRadius: 2.0,
                  offset: Offset(1, 1),
                  spreadRadius: 2.0)
            ]),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 200, 200, 200),
                                  blurRadius: 2.0,
                                  offset: Offset(1, 1),
                                  spreadRadius: 2.0)
                            ]),
                        child: CupertinoButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            borderRadius: BorderRadius.circular(100),
                            color: CupertinoTheme.of(context).primaryColor,
                            child: Icon(Icons.arrow_forward),
                            onPressed: login),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                OtherLogin(),
                WeixinLogin(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

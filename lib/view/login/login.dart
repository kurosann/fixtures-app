import 'package:fixtures/view/login/phoneLogin.dart';
import 'package:fixtures/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Material(
            color: Color.fromRGBO(245, 245, 245, 1),
            child: Column(
              children: <Widget>[
                CupertinoPageScaffold(
                  child: Form(
                    onChanged: () {
                      Form.of(primaryFocus!.context!)?.save();
                    },
                    child: CupertinoFormSection.insetGrouped(
                      margin: EdgeInsets.all(20),
                      header: LoginHeard(),
                      children: <Widget>[
                        CupertinoTextField(
                          controller: phoneText,
                          placeholderStyle: PhoneTextStyle(),
                          decoration: TextFieldBoxStyle(),
                          prefix: new Icon(
                            Icons.perm_identity,
                            color: Color.fromARGB(255, 126, 126, 126),
                          ),
                          placeholder: '请输入手机号',
                          cursorColor: Color.fromARGB(255, 126, 126, 126),
                          keyboardType: TextInputType.phone,
                          suffix: new IconButton(
                            icon: UserClose(),
                            onPressed: () {
                              phoneText.clear();
                            },
                          ),
                        ),
                        CupertinoTextField(
                          controller: password,
                          placeholderStyle: PhoneTextStyle(),
                          decoration: TextFieldBoxStyle(),
                          prefix: new Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 126, 126, 126),
                          ),
                          placeholder: '请输入密码',
                          cursorColor: Color.fromARGB(255, 126, 126, 126),
                          keyboardType: TextInputType.visiblePassword,
                          suffix: new IconButton(
                            icon: new Icon(
                              isShowPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: () {
                              setState(() {
                                isShowPassWord = !isShowPassWord;
                              });
                            },
                          ),
                          obscureText: !isShowPassWord,
                        ),
                      ],
                    ),
                  ),
                ),
                UserInfo(context, CodeLogin(context)),
                CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    color: Color(0xFFF16F15),
                    child: TextBtnStyle(),
                    onPressed: login),
                OtherLogin(),
                WeixinLogin(),
                ImageLogin()
              ],
            ),
          ),
        ));
  }
}

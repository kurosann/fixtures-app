import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle BlackStyle() {
  return TextStyle(
    fontSize: 12,
    textBaseline: TextBaseline.alphabetic,
    color: Color(0xFF333333),
  );
}

TextStyle BlueStyle() {
  return TextStyle(
    fontSize: 12,
    color: Colors.lightBlue,
  );
}

BoxDecoration BoxDecorationStyle() {
  return new BoxDecoration(
      border: new Border(
          bottom: BorderSide(
              color: Color.fromARGB(255, 240, 240, 240), width: 1.0)));
}

TextStyle PhoneTextStyle() {
  return new TextStyle(fontWeight: FontWeight.w500,fontSize: 12.0, color: Color.fromARGB(255, 93, 93, 93));
}

ButtonStyle LoginBtnStyle() {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(150, 50)),
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE56813)),
  );
}

Text TextBtnStyle() {
  return Text(
    '登录',
    style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24.0,),
  );
}

TextStyle LoginTextStyle() {
  return TextStyle(fontWeight: FontWeight.w100,fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255));
}

BoxDecoration OtherBox() {
  return BoxDecoration(
      gradient: new LinearGradient(colors: [
    Colors.black54,
    Colors.black54,
  ]));
}

BoxDecoration TextFieldBoxStyle() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(17.0),
    color: Color.fromARGB(255, 242, 242, 243),
    border: Border.all(
      color:  Color.fromARGB(255, 242, 242, 243),
      style: BorderStyle.none,
      width: 1,
    ),
  );
}

Icon UserClose() {
  return Icon(
    Icons.close_rounded,
    size: 24,
    color: Color.fromARGB(255, 82, 81, 81),
  );
}

Padding mypaddingIcon(int type){
  return Padding(
    padding: EdgeInsets.all(12),
    child: new Icon(
      type == 1 ? Icons.person : (type == 2 ?  Icons.email:Icons.lock),
      color: Color.fromARGB(255, 126, 126, 126),
    ),
  );
}

Icon passwordEyeIcon(bool isShowPassWord){
  return new Icon(
    isShowPassWord
        ? Icons.visibility
        : Icons.visibility_off,
    color: Color.fromARGB(255, 126, 126, 126),
  );
}


BoxShadow myBoxShadow(){
  return new BoxShadow(
      color:
      Color.fromARGB(255, 200, 200, 200),
      blurRadius: 2.0,
      offset: Offset(1, 1),
      spreadRadius: 2.0);
}

Text mySelectLoginWay(bool _isPhone){
  return Text(
    _isPhone ? '用账号密码登录' : '短信验证码登录',
    style: TextStyle(fontSize: 12),
  );
}
BoxDecoration myBoxDecoration(bool isValid){
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      boxShadow: isValid ? [myBoxShadow()] : []);
}



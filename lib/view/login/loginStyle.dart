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
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: Color.fromARGB(255, 126, 126, 126),
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

Text LoginHeard() {
  return const Text('请输入您的手机号码，登录或注册您的小求账号',
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: Color.fromARGB(255, 12, 12, 12)));
}

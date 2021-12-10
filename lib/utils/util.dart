import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize emptyAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery
        .of(context)
        .size
        .height * 0.07),
    child: SafeArea(
      top: true,
      child: Offstage(),
    ),
  );
}

ButtonStyle mainButtonStyle() {
  return ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.black12),
      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
      foregroundColor: MaterialStateProperty.all(Colors.black87));
}

String dataFormat(date) {
  return "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}


bool validateMobile(String str) {
  return new RegExp(
      '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
      .hasMatch(str);
}
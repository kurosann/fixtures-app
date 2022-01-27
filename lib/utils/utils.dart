import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize emptyAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
    child: SafeArea(
      top: true,
      child: Offstage(),
    ),
  );
}

ButtonStyle mainButtonStyle() {
  return ButtonStyle(
      //圆角
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      overlayColor: MaterialStateProperty.all(Colors.black12),
      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
      foregroundColor: MaterialStateProperty.all(Colors.black87));
}

String dataGetWorkFormat(date) {
  return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

String dataBirthFormat(date) {
  return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

bool validateMobile(String str) {
  return new RegExp(
          '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
      .hasMatch(str);
}

Widget actionCell(
    {IconData? icon,
    required String title,
    required Widget tailing,
    required onPressed}) {
  return Container(
    color: CupertinoColors.lightBackgroundGray,
    child: CupertinoButton(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(0),
      padding: EdgeInsets.all(8),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon != null
                    ? Container(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          icon,
                          color: CupertinoColors.inactiveGray,
                          size: 20,
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
            tailing
          ],
        ),
      ),
    ),
  );
}

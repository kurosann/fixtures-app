import 'package:flutter/cupertino.dart';

Widget emptyAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
    child: SafeArea(
      top: true,
      child: Offstage(),
    ),
  );
}

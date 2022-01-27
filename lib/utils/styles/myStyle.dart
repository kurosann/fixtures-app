import 'package:flutter/material.dart';

TextStyle myTextFieldStyle() {
  return TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 14.0,
    color: Color.fromARGB(255, 93, 93, 93),
  );
}

TextStyle myPlaceholderStyle() {
  return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      color: Color.fromARGB(255, 93, 93, 93));
}

BoxDecoration ourTextFieldBoxStyle() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(17.0),
    color: Color.fromARGB(255, 242, 242, 243),
    border: Border.all(
      color: Color.fromARGB(255, 242, 242, 243),
      style: BorderStyle.none,
      width: 1,
    ),
  );
}

BoxDecoration orderCard() {
  return BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(12));
}

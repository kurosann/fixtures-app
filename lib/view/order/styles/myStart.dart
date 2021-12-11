import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration orderCard() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.white,
            blurRadius: 1.0,
            spreadRadius: 1.0)
      ],
      border: Border.all(
        color: Color.fromARGB(255, 200, 200, 200),
        width: 1,
        style: BorderStyle.none,
      ));
}

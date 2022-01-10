import 'package:flutter/material.dart';

class ApiConfig {
  static const BASE_URL = "http://127.0.0.1";

  static const ACCESS_TOKEN = "Authorization";
  static const REFRESH_TOKEN = "ReAuthorization";

  static bool isDebug = true; //是否是调试模式
  static bool dark = false;
  static Color fontColor = Colors.black54;
}

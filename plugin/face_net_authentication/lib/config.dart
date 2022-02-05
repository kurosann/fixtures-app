import 'package:flutter/material.dart';

class Config {
  /// 接口相关
  static const BASE_URL ="http://7e67-117-183-86-180.ngrok.io";
  static const AES_KEY ="65696a042e6551bb8a4a66b3aabaec9a";

  /// Token相关
  static const ACCESS_TOKEN = "Authorization";
  static const SECURITY_KEY = "securitykey";


  /// 微信相关
  static const WX_UNIVERSAL_LINK = "wxd930ea5d5a228f5f";
  static const WX_APP_ID = "https://your.univerallink.com/link/";

  /// 日志调试相关
  static bool isDebug = true; //是否是调试模式
  static bool dark = false;
  static Color fontColor = Colors.black54;
}

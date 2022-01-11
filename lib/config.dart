import 'package:flutter/material.dart';

class Config {
  /// 接口相关
  static const BASE_URL = "http://83c2-113-110-166-213.ngrok.io";


  /// Token相关
  static const ACCESS_TOKEN = "Authorization";
  static const REFRESH_TOKEN = "ReAuthorization";


  /// 微信相关
  static const WX_UNIVERSAL_Link = "wxd930ea5d5a228f5f";
  static const WX_APP_ID = "https://your.univerallink.com/link/";

  /// 日志调试相关
  static bool isDebug = true; //是否是调试模式
  static bool dark = false;
  static Color fontColor = Colors.black54;
}

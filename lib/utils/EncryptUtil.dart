/**
 *  jh_encrypt_utils.dart
 *
 *  Created by iotjin on 2020/08/18.
 *  description: base64 , aes加解密(CBC/PKCS7)
 */

import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:fixtures/config.dart';
var _IV = "00000000000000000000000000000000";
//128的keysize=16，192keysize=24，256keysize=32

class EncryptUtil {

  //AES加密
  static aesEncrypt(plainText) {
    try {
      final key = Key.fromUtf8(Config.AES_KEY);
      final iv = IV.fromUtf8(Config.AES_KEY);
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return plainText;
    }
  }
  //AES解密
  static dynamic aesDecrypt(encrypted) {
    try {
      final key = Key.fromUtf8(Config.AES_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return encrypted;
    }
  }
}
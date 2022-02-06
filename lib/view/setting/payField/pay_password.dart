
///  支符密码  用于 密码输入框和键盘之间进行通信
class KeyEvents {
  String key;

  KeyEvents(this.key);

  bool isDelete() => this.key == "del";
  bool isCommit() => this.key == "commit";
}

import 'package:fixtures/view/personal/styles/myStyle.dart';
import 'package:fixtures/widget/stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditOurPage extends StatefulWidget {
  static EditOurPage? _instance;

  static EditOurPage get instance {
    if (_instance == null) {
      _instance = EditOurPage();
    }
    return _instance!;
  }

  @override
  State<StatefulWidget> createState() => _EditOurPageState();
}

class _EditOurPageState extends State<EditOurPage> {
  final _userName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _certificate = TextEditingController();
  final divider = Divider(height: 1, indent: 20);
  final rightIcon = Icon(Icons.keyboard_arrow_right);
  var _selectValue = TextEditingController(text:"身份证");
  var positions = <String>["身份证", "护照"];
  bool _isSelect = false;

  void _showLocalPick(context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("选择证件类型"),
          actions: [
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
                setState(() {
                  _isSelect = !_isSelect;
                });
                Navigator.of(context).pop();
              },
            )
          ],
          content: Container(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 28,
              onSelectedItemChanged: (int value) {
                setState(() {
                  _selectValue = TextEditingController(text:positions[value]);
                });
              },
              children: positions.map((e) => Text(e)).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            previousPageTitle: '设置',
          ),
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: CupertinoSliverRefreshControl(
                  onRefresh: () async {},
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        '以下信息用于核实您的真实身份',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "实名认证可能会影响到您的下单服务，请认真填写",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: CupertinoTextField(
                        controller: _userName,
                        prefix: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text('姓名：', style: myTextFieldStyle())),
                        placeholderStyle: myPlaceholderStyle(),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: CupertinoTextField(
                        controller: _phoneNumber,
                        prefix: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text('手机号：', style: myTextFieldStyle())),
                        placeholderStyle: myPlaceholderStyle(),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: CupertinoTextField(
                        controller: _selectValue,
                        readOnly: true,
                        prefix: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text('选择证件类型：', style: myTextFieldStyle())),
                          suffix: Padding(
                            padding: const EdgeInsets.all(12),
                              child: Center(
                                child: new GestureDetector(
                                  child:Icon(
                                    _isSelect ? Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right,
                                    size: 24,
                                    color: Color.fromARGB(255, 82, 81, 81),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isSelect = !_isSelect;
                                    });
                                    _showLocalPick(context);
                                  },
                                ),
                              ),
                          )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: CupertinoTextField(
                        controller: _certificate,
                        prefix: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text('证件号：', style: myTextFieldStyle())),
                        placeholderStyle: myPlaceholderStyle(),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: CupertinoButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue,
                          child: Text("下一步"),
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

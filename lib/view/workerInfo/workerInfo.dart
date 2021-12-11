import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkerInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkerInfoPageState();

}

class _WorkerInfoPageState extends State<WorkerInfoPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      child: ListView(
        children: [
          _head(),
        ],
      ),
    );
  }

  Widget _head() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://img1.baidu.com/it/u=105496718,1970821593&fm=26&fmt=auto"),
          radius: 40,
        ),
      ],
    );
  }
}
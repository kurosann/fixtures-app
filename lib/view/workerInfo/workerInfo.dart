import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkerInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkerInfoState();

}

class _WorkerInfoState extends State<WorkerInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
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
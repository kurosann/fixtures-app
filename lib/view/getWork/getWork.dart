import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetWorkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetWorkState();
}

class GetWorkState extends State<GetWorkPage> {
  var orders = [1];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          stretch: true,
          largeTitle: Text("符合订单"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index.isOdd)
              return Divider(
                height: 1,
              );
            return _itemCell(index);
          }, childCount: orders.length * 2),
        )
      ],
    ));
  }

  Widget _itemCell(index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("姓名"),
              Text(dataFormat(DateTime.now()).toString()),
            ],
          ),
          Row(
            children: [
              Text("电话:${"0000000000"}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("需求"),
              CupertinoButton.filled(
                  minSize: 0,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                  borderRadius: BorderRadius.circular(16),
                  child: Text(
                    "联系客人",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {

                  })
            ],
          ),
        ],
      ),
    );
  }
}

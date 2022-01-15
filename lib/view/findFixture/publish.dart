import 'package:fixtures/model/Publish.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget {
  final String id;

  PublishPage({required this.id});

  @override
  State<StatefulWidget> createState() => PublishState(id: id);
}

class PublishState extends State<PublishPage> {
  var id;

  PublishState({@required this.id});

  var position = "惠州";

  var positions = <String>["惠州", "广州"];

  var publishList = <Publish>[Publish()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              previousPageTitle: '选择装修类型',
            middle: Text("发布需求"),
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
                    CupertinoButton(
                        child: Text('当前地区：$position'),
                        onPressed: () {
                          _showLocalPick(context);
                        })
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  if (i.isEven) return Divider();
                  final index = i ~/ 2;
                  var publish = publishList[index];
                  return _itemCell("陈师傅", "玻璃", "20mm");
                }, childCount: publishList.length * 2 + 1),
              )
            ],
          )),
    );
  }

  void _showLocalPick(context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("选择地区"),
          actions: [
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
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
                  position = positions[value];
                });
              },
              children: positions.map((e) => Text(e)).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _itemCell(String name, String fixture, String size) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        title: Text(name),
        subtitle: Text(fixture + "    " + size),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }
}

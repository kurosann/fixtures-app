import 'package:fixtures/model/Publish.dart';
import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/findFixture/publish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindFixturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindFixtureState();
}

class _FindFixtureState extends State<FindFixturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(context),
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              stretch: true,
              previousPageTitle: "小求",
              largeTitle: Text("找装修"),
            ),
            SliverFixedExtentList(
                itemExtent: 50,
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CupertinoSearchTextField(
                      prefixIcon: Icon(CupertinoIcons.search),
                      placeholder: "搜索",
                      suffixMode: OverlayVisibilityMode.editing,
                    ),
                  );
                }, childCount: 1)),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 30.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.4,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return GestureDetector(
                    child: _itemCell("门窗",
                        "https://img2.baidu.com/it/u=2548989639,546384781&fm=15&fmt=auto"),
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PublishPage(id: "1",),));
//                      Navigator.pushNamed(context, '/findFixture/publish');
                    },
                  );
                },
                childCount: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemCell(label, imageUrl) {
    return Card(
      child: Column(
        children: [
          Image(
            image: NetworkImage(imageUrl),
            width: 50,
            height: 50,
          ),
          Text(label),
        ],
      ),
    );
  }
}

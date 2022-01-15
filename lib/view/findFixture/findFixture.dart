import 'package:fixtures/utils/util.dart';
import 'package:fixtures/view/findFixture/publish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindFixturePage extends StatefulWidget {
  static FindFixturePage? _instance;

  static FindFixturePage get instance {
    if (_instance == null) {
      _instance = FindFixturePage();
    }
    return _instance!;
  }

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
              largeTitle: Text("选择装修类型"),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CupertinoSearchTextField(
                  prefixIcon: Icon(CupertinoIcons.search),
                  placeholder: "搜索",
                  suffixMode: OverlayVisibilityMode.editing,
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 30.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.4,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _itemCell(
                      "门窗",
                      "https://img2.baidu.com/it/u=2548989639,546384781&fm=15&fmt=auto",
                      "1");
                },
                childCount: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemCell(label, imageUrl, id) {
    return Card(
      child: TextButton(
        style: mainButtonStyle(),
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
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => PublishPage(
              id: id,
            ),
          ));
        },
      ),
    );
  }
}

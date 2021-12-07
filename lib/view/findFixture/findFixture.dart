import 'package:fixtures/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindFixturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FindFixture();
}

class FindFixture extends State<FindFixturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(context),
      body: CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CupertinoSliverNavigationBar(
                padding: EdgeInsetsDirectional.all(4),
                previousPageTitle: "返回",
                middle: Text("找装修"),
                largeTitle: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoSearchTextField(
                    prefixIcon: Icon(CupertinoIcons.search),
                    placeholder: "搜索",
                    suffixMode: OverlayVisibilityMode.editing,
                  ),
                ),
              ),
            ];
          },
          body: GridView.builder(
            itemCount: 12,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                childAspectRatio: 1.4,
                mainAxisSpacing: 20),

            itemBuilder: (context, index) => GestureDetector(
              child: _itemCell("门窗",
                  "https://img2.baidu.com/it/u=2548989639,546384781&fm=15&fmt=auto"),
              onTap: () {
                Navigator.pushNamed(context, '/findFixture/publish');
              },
            ),
          ),
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

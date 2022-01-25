import 'package:fixtures/config.dart';
import 'package:fixtures/model/ItemModel.dart';
import 'package:fixtures/service/api/ItemApi.dart';
import 'package:fixtures/utils/utils.dart';
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

class _FindFixtureState extends State<FindFixturePage> with ItemMixin {
  List<dynamic> itemList = [];
  int count = 0;
  final itemName = TextEditingController();

  @override
  void initState() {
    getList("");
  }

  void openMsg(String msg) {
    if (context != null)
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('提示'),
              content: Text(msg),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('确认'),
                  onPressed: () {
                    Navigator.of(context).pop("ok");
                  },
                ),
              ],
            );
          });
  }

  void getList(String name) {
    var models = ItemModel(id: 0, itemName: name);
    getItem(
      params: models,
      successCallBack: (data) {
        var list = data["list"];
        setState(() {
          count = data["count"];
          itemList = list;
        });
        print(itemList.toString());
      },
      errorCallBack: (code, err) {
        if (code == 500) {
          openMsg(err);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(context),
      body: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              stretch: true,
              previousPageTitle: "小求",
              largeTitle: Text("选择装修类型"),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CupertinoSearchTextField(
                  style: TextStyle(height: 1.4),
                  backgroundColor: Colors.white,
                  controller: itemName,
                  prefixIcon: Icon(CupertinoIcons.search),
                  placeholder: "搜索",
                  suffixMode: OverlayVisibilityMode.editing,
                  onTap: () {
                    getList(itemName.text);
                  },
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.4,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _itemCell(
                      itemList[index]["itemName"],
                      Config.BASE_URL + itemList[index]["image_url"],
                      itemList[index]["id"]);
                },
                childCount: count,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemCell(label, imageUrl, id) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      //圆角
      decoration: new BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        // //背景
        // color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
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

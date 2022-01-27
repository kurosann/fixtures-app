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
//          openMsg(err);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            stretch: true,
            previousPageTitle: "小求",
            largeTitle: Text("装修类型"),
            backgroundColor: CupertinoColors.systemGroupedBackground,
            border: Border.all(color: CupertinoColors.white.withAlpha(0)),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: CupertinoSearchTextField(
                backgroundColor: Colors.white,
                controller: itemName,
                prefixIcon: Icon(CupertinoIcons.search),
                prefixInsets: EdgeInsets.only(left: 8, top: 2),
                placeholder: "搜索",
                suffixMode: OverlayVisibilityMode.editing,
                onSubmitted: (v) {
                  getList(itemName.text);
                },
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {

            },
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              maxCrossAxisExtent: 150.0,
              childAspectRatio: 0.4,
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
    );
  }

  Widget _itemCell(label, imageUrl, id) {
    return Container(
      color: CupertinoColors.lightBackgroundGray,
      child: CupertinoButton(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(0),
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

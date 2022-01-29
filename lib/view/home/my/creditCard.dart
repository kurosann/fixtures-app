import 'package:fixtures/model/IdCardModel.dart';
import 'package:fixtures/service/api/IdCardApi.dart';
import 'package:fixtures/view/home/my/addBankCard.dart';
import 'package:flutter/cupertino.dart';

class CreditCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage>  with IdCardApi {
  var IdCardList = <IdCardModel>[];
  int total = 0;
  void openMsg(String msg) {
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

  void findIdCard(){
    getIdCard(
        successCallBack: (data) {
          IdCardList = <IdCardModel>[];
          setState(() {
            total = data["total"];
            var list = data["list"];
            for (int i = 0; i < total; i += 1){
              IdCardList.add(IdCardModel(
                id:list[i]["id"],
                userId:list[i]["userId"],
                bankName:list[i]["bankName"],
                bankCardNo:list[i]["bankCardNo"],
                cardOwner:list[i]["cardOwner"],
                idCard:list[i]["idCard"],
                phone:list[i]["phone"],
                treatyState:list[i]["treatyState"],
                remake:list[i]["remake"],
              ));
            }
          });
        },
        errorCallBack: (code, err) {
          if (code == 500) {
            openMsg(err);
          }
        }
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findIdCard();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverSafeArea(
              sliver: CupertinoSliverRefreshControl(
                onRefresh: () async {},
              ),
            ),
            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              border: Border.all(color: CupertinoColors.white.withAlpha(0)),
              previousPageTitle: '返回',
              largeTitle: Text('银行卡'),
              trailing: CupertinoButton(
                padding: EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return AddBankCard();
                    },
                  ));
                },
                child: Icon(CupertinoIcons.plus),
              ),
            ),
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: total,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: CupertinoColors.lightBackgroundGray,
                        child: CupertinoButton(
                          color: CupertinoColors.white,
                          padding: EdgeInsets.all(0),
                          borderRadius: BorderRadius.circular(0),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      child: Text(
                                        IdCardList[index].bankName!,
                                        style: TextStyle(
                                            color: CupertinoColors.black),
                                      ),
                                    ),
                                    Text(
                                      "尾号：${IdCardList[index].bankCardNo!}",
                                      style: TextStyle(
                                          color: CupertinoColors.inactiveGray,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

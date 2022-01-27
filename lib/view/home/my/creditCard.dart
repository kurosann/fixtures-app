import 'package:fixtures/view/home/my/addBankCard.dart';
import 'package:flutter/cupertino.dart';

class CreditCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
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
                itemCount: 10,
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
                                        "卡名",
                                        style: TextStyle(
                                            color: CupertinoColors.black),
                                      ),
                                    ),
                                    Text(
                                      "尾号：0000",
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

import 'package:fixtures/utils/utils.dart';
import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/login/login.dart';
import 'package:fixtures/view/setting/rePassword.dart';
import 'package:fixtures/view/setting/rePayPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'rePwdSms.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(slivers: [
        CupertinoSliverNavigationBar(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          border: Border.all(color: CupertinoColors.white.withAlpha(0)),
          stretch: true,
          largeTitle: Text("设置"),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: [
                  actionCell(
                      title: "修改登录密码",
                      tailing: Icon(
                        CupertinoIcons.forward,
                        size: 16,
                        color: CupertinoColors.inactiveGray,
                      ),
                      onPressed: () {
                        Navigator.of(allContext!).push(
                            CupertinoPageRoute(builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: RePassWord(),
                          );
                        }));
                      }),
                  actionCell(
                      title: "修改支付密码",
                      tailing: Icon(
                        CupertinoIcons.forward,
                        size: 16,
                        color: CupertinoColors.inactiveGray,
                      ),
                      onPressed: () {
                        Navigator.of(allContext!).push(
                            CupertinoPageRoute(builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: RePwdSms(),
                          );
                        }));
                      }),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 20),
                    child: Divider(
                      height: 1.0,
                    ),
                  ),
                  actionCell(
                      title: "关于页面",
                      tailing: Icon(
                        CupertinoIcons.forward,
                        size: 16,
                        color: CupertinoColors.inactiveGray,
                      ),
                      onPressed: () {
                        Navigator.of(allContext!).push(
                            CupertinoPageRoute(builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            child: Container(),
                          );
                        }));
                      }),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 20),
                    child: Divider(
                      height: 1.0,
                    ),
                  ),
                  actionCell(
                      title: "退出登录",
                      tailing: Icon(
                        CupertinoIcons.forward,
                        size: 16,
                        color: CupertinoColors.inactiveGray,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false);
                      }),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

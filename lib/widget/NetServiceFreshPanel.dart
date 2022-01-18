import 'dart:ui';

import 'package:fixtures/service/base/HttpManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef NetCallback = Future<Result> Function();

/// 网络请求状态面板
class NetServiceFreshPanel extends StatefulWidget {
  /// 待加载页面
  final Widget child;

  /// 加载中页面 为null则为默认loading界面
  final Widget? loadingPanel;

  /// 网络请求 为空可使用[state]控制
  final NetCallback? onRequest;

  /// 页面状态为 [NetServiceState.STATE_SUCCESS] 时显示 [child]
  final NetServiceState state;

  NetServiceFreshPanel(
      {this.state = NetServiceState.STATE_ING,
      required this.child,
      this.loadingPanel,
      this.onRequest});

  @override
  State<StatefulWidget> createState() =>
      _NetServiceRefresh(state, child, loadingPanel, onRequest);
}

class _NetServiceRefresh extends State<NetServiceFreshPanel> {
  NetServiceState state;

  Widget child;

  Widget? loadingPanel;

  NetCallback? getData;

  _NetServiceRefresh(this.state, this.child, this.loadingPanel, this.getData);

  void _refresh() async {
    setState(() {
      state = NetServiceState.STATE_ING;
    });
    Result data = await getData!();
    setState(() {
      state = data.code == ResultCode.SUCCESS
          ? NetServiceState.STATE_SUCCESS
          : NetServiceState.STATE_ERROR;
    });
  }

  @override
  void initState() {
    if (getData != null) _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          child,
          state == NetServiceState.STATE_ING
              ? loadingPanel != null
                  ? loadingPanel!
                  : BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Color.fromARGB(100, 255, 255, 255),
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(),
                      ),
                    )
              : state == NetServiceState.STATE_ERROR
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Color.fromARGB(100, 255, 255, 255),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: CupertinoTheme.of(context).primaryColor,
                            ),
                            Text("网络错误"),
                            CupertinoButton(
                                child: Text("重新加载"),
                                onPressed: () {
                                  _refresh();
                                })
                          ],
                        ),
                      ),
                    )
                  : Container(),
        ],
      ),
    );
  }
}

enum NetServiceState {
  /// 请求成功
  STATE_SUCCESS,

  ///请求失败
  STATE_ERROR,

  ///请求中
  STATE_ING
}

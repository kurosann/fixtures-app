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

  /// 页面状态为 [NetServiceState.SUCCESS] 时显示 [child]
  NetServiceState state;

  /// 状态面板背景色 不设置则为Theme的appbar背景色
  final Color? backgroundColor;

  NetServiceFreshPanel(
      {this.state = NetServiceState.PROCESS,
      required this.child,
      this.loadingPanel,
      this.backgroundColor,
      this.onRequest});

  @override
  State<StatefulWidget> createState() => _NetServiceRefresh();
}

class _NetServiceRefresh extends State<NetServiceFreshPanel> {
  var state = NetServiceState.SUCCESS;

  void _refresh() async {
    setState(() {
      state = NetServiceState.PROCESS;
    });
    Result data = await widget.onRequest!();
    setState(() {
      state = (data.code == ResultCode.SUCCESS)
          ? NetServiceState.SUCCESS
          : NetServiceState.ERROR;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.onRequest != null) _refresh();
  }
@override
  void didUpdateWidget(covariant NetServiceFreshPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      state = widget.state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          widget.child,
          state == NetServiceState.PROCESS
              ? widget.loadingPanel != null
                  ? widget.loadingPanel!
                  : BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: widget.backgroundColor != null
                            ? widget.backgroundColor
                            : CupertinoTheme.of(context).barBackgroundColor,
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(),
                      ),
                    )
              : widget.state == NetServiceState.ERROR
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: widget.backgroundColor != null
                            ? widget.backgroundColor
                            : CupertinoTheme.of(context).barBackgroundColor,
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
  SUCCESS,

  ///请求失败
  ERROR,

  ///请求中
  PROCESS
}

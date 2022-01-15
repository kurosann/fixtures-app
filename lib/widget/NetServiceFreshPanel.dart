import 'package:fixtures/service/base/HttpManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef NetDateCallback = Future<Result> Function();

class NetServiceFreshPanel extends StatefulWidget {
  final Widget child;

  final NetDateCallback? onNetData;

  final NetServiceState? state;

  NetServiceFreshPanel(
      {this.state = NetServiceState.STATE_ING,
      required this.child,
      this.onNetData})
      : assert(onNetData != null || state != null);

  @override
  State<StatefulWidget> createState() =>
      _NetServiceRefresh(state!, child, onNetData);
}

class _NetServiceRefresh extends State<NetServiceFreshPanel> {
  NetServiceState state = NetServiceState.STATE_ING;

  Widget _child;

  NetDateCallback? getData;

  _NetServiceRefresh(this.state, this._child, this.getData);

  void _refresh() async {
    setState(() {
      state = NetServiceState.STATE_ING;
    });
    Result data = await getData!();
    setState(() {
      state = data.code == 200
          ? NetServiceState.STATE_SUCCESS
          : NetServiceState.STATE_ERROR;
    });
  }

  @override
  void initState() {
    if (getData != null) _refresh();
//    else
//      state = NetServiceState.STATE_SUCCESS;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _child,
          state == NetServiceState.STATE_ING
              ? Container(
                  color: Color.fromARGB(200, 255, 255, 255),
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
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

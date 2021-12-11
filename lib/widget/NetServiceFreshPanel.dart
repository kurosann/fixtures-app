import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetServiceFreshPanel extends StatefulWidget {
  Widget child;

  Function? onNetData;

  NetServiceState? state;

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

  Function? getData;

  _NetServiceRefresh(this.state, this._child, this.getData);

  void _refresh() async {
    setState(() {
      state = NetServiceState.STATE_ING;
    });
    await getData!();
    setState(() {
      state = NetServiceState.STATE_SUCCESS;
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
          _child,
          state == NetServiceState.STATE_ING
              ? Container(
                  color: Color.fromARGB(50, 255, 255, 255),
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}

enum NetServiceState { STATE_SUCCESS, STATE_ERROR, STATE_ING }
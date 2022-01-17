import 'package:fixtures/view/home/home.dart';
import 'package:fixtures/view/order/orderDetail.dart';
import 'package:fixtures/widget/stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HandlingOrderPage extends StatefulWidget {
  final String id;

  HandlingOrderPage({required this.id});

  @override
  State<StatefulWidget> createState() => _HandlerOrderState(id: id);
}

class _HandlerOrderState extends State<HandlingOrderPage>
    with SingleTickerProviderStateMixin {
  final String id;
  int currentStep = 0;
  int currentRealStep = 2;

  var sizeFieldController = TextEditingController();

  String sizeInput = "";

  _HandlerOrderState({required this.id}) {
    currentStep = currentRealStep;
  }

  AnimationController? _animationController;

  var isRefresh = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: "订单",
        middle: Text("您正在处理的订单")
      ),
      child: CustomScrollView(
        slivers: [
          SliverSafeArea(
            sliver: CupertinoSliverRefreshControl(
              onRefresh: () async {},
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoStepper(
              physics: NeverScrollableScrollPhysics(),
              controlsBuilder: (context, details) {
                return ButtonBar(
                  children: [
                    details.currentStep! == 0
                        ? CupertinoButton(
                            child: Text(
                              "修改尺寸",
                              style: TextStyle(fontSize: 12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            onPressed: () {
                              showEditSizeModel();
                            })
                        : Container(),
                    CupertinoButton(
                        child: Text("去付款", style: TextStyle(fontSize: 14)),
                        color: Colors.greenAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        onPressed: () {
//                        _animationController!.forward();
                          Navigator.of(allContext!).push(CupertinoPageRoute(
                            builder: (context) {
                              return OrderDetailPage();
                            },
                          ));
                        }),
                    CupertinoButton.filled(
                      child: Text("确认完成", style: TextStyle(fontSize: 14)),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      onPressed: null,
                    )
                  ],
                );
              },
              type: StepperType.vertical,
              currentStep: currentStep,
              onStepTapped: (step) => setState(() => currentStep = step),
              steps: [
                _buildStep(
                  title: Text('现场勘察'),
                  subtitle: Text(DateTime.now().toString()),
                  currentIndex: 0,
                  realIndex: 0,
                  price: 40,
                  percent: 0.1,
                ),
                _buildStep(
                  title: Text('材料准备'),
                  subtitle: Text(DateTime.now().toString()),
                  currentIndex: 1,
                  realIndex: 1,
                  price: 120,
                  percent: 0.4,
                ),
                _buildStep(
                  title: Text('材料到位'),
                  subtitle: Text(DateTime.now().toString()),
                  currentIndex: 2,
                  realIndex: 2,
                  price: 160,
                  percent: 0.8,
                ),
                _buildStep(
                  title: Text('完工'),
                  subtitle: Text(DateTime.now().toString()),
                  currentIndex: 3,
                  realIndex: 3,
                  price: 40,
                  percent: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Step _buildStep({
    required Widget title,
    required Widget subtitle,
    required double price,
    required double percent,
    required int currentIndex,
    required int realIndex,
  }) {
    return Step(
      title: Row(
        children: [
          title,
          Text(currentRealStep == realIndex ? ' (进行中)' : ''),
        ],
      ),
      subtitle: subtitle,
      state:
          currentStep == currentIndex ? StepState.editing : StepState.indexed,
      isActive: currentStep == currentIndex,
      content: LimitedBox(
        maxWidth: 300,
        maxHeight: 50,
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("费用"),
                  Text("$price元"),
                  Text("(总额${percent * 100}%)"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("未支付"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showEditSizeModel() {
    showCupertinoDialog(
      context: allContext!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("输入尺寸"),
          content: CupertinoTextField(
            style: TextStyle(height: 1.4),
            controller: sizeFieldController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            placeholder: "请重新输入尺寸",
            clearButtonMode: OverlayVisibilityMode.editing,
            autofocus: true,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("取消"),
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text("确定"),
              isDefaultAction: true,
              onPressed: () {
                sizeInput = sizeFieldController.text;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

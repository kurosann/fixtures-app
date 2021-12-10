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

  _HandlerOrderState({required this.id}) {
    currentStep = currentRealStep;
  }

  AnimationController? controller;

  var isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("您正在处理的订单"),
        trailing: isRefresh
            ? CupertinoActivityIndicator()
            : GestureDetector(
                onTap: () {
                  setState(() {
                    isRefresh = true;
                  });
                },
                child: Icon(
                  Icons.refresh,
                  size: 26,
                ),
              ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CupertinoStepper(
              physics: NeverScrollableScrollPhysics(),
              controlsBuilder: (context, details) {
                return ButtonBar(
                  children: [
                    CupertinoButton.filled(
                        child: Text("去付款"),
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        onPressed: () {}),
                    CupertinoButton.filled(
                      child: Text("确认完成"),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 4),
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
                  Subtitle: Text(DateTime.now().toString()),
                  currentIndex: 0,
                  realIndex: 0,
                  price: 40,
                  percent: 0.1,
                ),
                _buildStep(
                  title: Text('材料准备'),
                  Subtitle: Text(DateTime.now().toString()),
                  currentIndex: 1,
                  realIndex: 1,
                  price: 120,
                  percent: 0.4,
                ),
                _buildStep(
                  title: Text('材料到位'),
                  Subtitle: Text(DateTime.now().toString()),
                  currentIndex: 2,
                  realIndex: 2,
                  price: 160,
                  percent: 0.8,
                ),
                _buildStep(
                  title: Text('完工'),
                  Subtitle: Text(DateTime.now().toString()),
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
    required Widget Subtitle,
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
      subtitle: Subtitle,
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
                  Text("${price}元"),
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
}

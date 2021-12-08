import 'package:fixtures/widget/stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HandlingOrderPage extends StatefulWidget {
  final String id;

  HandlingOrderPage({required this.id});

  @override
  State<StatefulWidget> createState() => _HandlerOrderState(id: id);
}

class _HandlerOrderState extends State<HandlingOrderPage> {
  final String id;
  int currentStep = 0;
  _HandlerOrderState({required this.id});

  @override
  Widget build(BuildContext context) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 3;
    return CupertinoPageScaffold(
      child: CupertinoStepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
        onStepContinue: canContinue ? () => setState(() => ++currentStep) : null,
        steps: [
          for (var i = 0; i < 3; ++i)
            _buildStep(
              title: Text('Step ${i + 1}'),
              isActive: i == currentStep,
              state: i == currentStep
                  ? StepState.editing
                  : i < currentStep ? StepState.complete : StepState.indexed,
            ),
          _buildStep(
            title: Text('Error'),
            state: StepState.error,
          ),
          _buildStep(
            title: Text('Disabled'),
            state: StepState.disabled,
          )
        ],
      ),
    );
  }
  Step _buildStep({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      subtitle: Text('Subtitle'),
      state: state,
      isActive: isActive,
      content: LimitedBox(
        maxWidth: 300,
        maxHeight: 300,
        child: Container(color: CupertinoColors.systemGrey),
      ),
    );
  }
}

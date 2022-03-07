import 'dart:developer';

import 'package:droneapp/widgets/manual_control/joystick/ActionState.dart';
import 'package:flutter/material.dart';

class ActionButtonsController {
  late void Function(ActionState) setArmState;
  late void Function(ActionState) setRecordState;
}

class ActionsButtons extends StatefulWidget {
  final ActionButtonsController actionButtonsController;

  final VoidCallback switchArmCallback;
  final VoidCallback switchRecordCallback;

  const ActionsButtons({Key? key, required this.actionButtonsController, required this.switchArmCallback, required this.switchRecordCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ActionsButtonsState(actionButtonsController);
}

class ActionsButtonsState extends State<ActionsButtons> {
  final ActionButtonsController _actionController;

  ActionState armState = ActionState.DISABLED;
  ActionState recordState = ActionState.DISABLED;

  ActionsButtonsState(this._actionController) {
    _actionController.setArmState = setArmedState;
    _actionController.setRecordState = setRecordingState;
  }

  @override
  Widget build(BuildContext context) {
    Color armButtonColor = _findColorByState(armState);
    Color recordButtonColor = _findColorByState(recordState);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: -1,
          child: TextButton(
              onPressed: widget.switchRecordCallback,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(recordButtonColor)),
              child: const Text("Record")),
        ),
        RotatedBox(
            quarterTurns: -1,
            child: TextButton(
                // Disable button if armed
                onPressed: armState == ActionState.DISABLED ? widget.switchArmCallback : null,
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(armButtonColor)),
                child: const Text("Arm"))),
        RotatedBox(
            quarterTurns: -1,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_sharp))),
      ],
    );
  }

  setArmedState(ActionState armState) {
    setState(() {
      armState = armState;
    });
  }

  setRecordingState(ActionState recordState) {
    setState(() {
      recordState = recordState;
    });
  }

  _findColorByState(ActionState state) {
    switch (state) {
      case ActionState.ENABLED:
        return Colors.green;
      case ActionState.DISABLED:
        return Colors.red;
      case ActionState.WAITING:
        return Colors.blue;
      default:
        log("No color found for state $state");
        return Colors.black;
    }
  }
}

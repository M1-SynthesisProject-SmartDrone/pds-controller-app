import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/widgets/manual_control/joystick/ActionButtons.dart';
import 'package:droneapp/widgets/manual_control/joystick/ActionState.dart';
import 'package:droneapp/widgets/manual_control/joystick/AnalogStick.dart';
import 'package:droneapp/widgets/manual_control/joystick/JoystickButtons.dart';
import 'package:flutter/cupertino.dart';

class JoystickController {
  late void Function(ActionState state) updateArmState;
  late void Function(ActionState state) updateRecordState;
}

class JoyStick extends StatelessWidget {
  final JoystickController joystickController;
  final VoidCallback switchArmCallback;
  final VoidCallback switchRecordCallback;

  final DroneControl control = DroneControl();
  final actionButtonsController = ActionButtonsController();

  JoyStick({Key? key, required this.joystickController, required this.switchArmCallback, required this.switchRecordCallback})
      : super(key: key) {
    joystickController.updateArmState = updateArmState;
    joystickController.updateRecordState = updateRecordState;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          JoystickButtons(
              rotateLeft: control.rotateLeft,
              rotateRight: control.rotateRight,
              resetRotation: control.resetRotation,
              moveDown: control.moveDown,
              moveUp: control.moveUp,
              resetVertical: control.resetVertical),
          const SizedBox(height: 70),
          ActionsButtons(actionButtonsController: actionButtonsController,
              switchArmCallback: switchArmCallback,
              switchRecordCallback: switchRecordCallback),
          const SizedBox(height: 70),
          AnalogStick(updateStickCallback: control.setDirection)
        ]));
  }

  updateArmState(ActionState state) {
    actionButtonsController.setArmState(state);
  }

  updateRecordState(ActionState state) {
    actionButtonsController.setRecordState(state);
  }
}

import 'dart:developer';

import 'package:droneapp/classes/CommunicationAPI/requests/ManualControlRequest.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/widgets/drone_data_display/DroneData.dart';
import 'package:droneapp/widgets/manual_control/joystick/ActionState.dart';
import 'package:droneapp/widgets/manual_control/joystick/Joystick.dart';
import 'package:droneapp/widgets/util/ToastUtil.dart';
import 'package:flutter/material.dart';

import '../../classes/DroneCommunication.dart';

class ManualControl extends StatelessWidget {
  final DroneControl control = DroneControl();
  final DroneCommunication droneCommunication = DroneCommunication();

  // This is a pattern used by flutter itself in order to handle communication with children
  final JoystickController joystickController = JoystickController();

  ManualControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _sendManualControl() {
      Future.delayed(const Duration(milliseconds: 300), () async {
        await droneCommunication.networkControl
            .sendRequest(ManualControlRequest(control.x, control.y, control.z, control.r));
        if (control.isArmed) {
          _sendManualControl();
        }
      });
    }

    void _switchArm() {
      if (control.isArmed) {
        ToastUtil.showToast(context, "Cannot disarm drone (the drone will be disarmed automatically)");
      } else {
        joystickController.updateArmState(ActionState.WAITING);
        log("Ask to arm the drone");
        droneCommunication.armDrone().then((_) {
          control.arm();
          log("Drone armed (${control.isArmed})");
          joystickController.updateArmState(ActionState.ENABLED);
          log("Action state done");
          _sendManualControl();
          // TODO : launch reception messages
          // TODO : launch timer for sending messages
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Arming Drone : " + e.toString());
          control.unArm();
          log("control arm -> " + control.isArmed.toString());
          joystickController.updateArmState(ActionState.DISABLED);
        });
      }
    }

    void _switchRecord() {
      control.switchRecording();
      if (control.isRecording == true) {
        droneCommunication.startRecording().then((_) {
          log("control rec -> " + control.isRecording.toString());
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Starting Record: " + e.toString());
          control.endRecord();
          log("control rec -> " + control.isRecording.toString());
        });
      } else {
        droneCommunication.endRecording().then((_) {
          log("control rec -> " + control.isRecording.toString());
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Ending Record: " + e.toString());
          control.startRecord();
          log("control rec -> " + control.isRecording.toString());
        });
      }
    }

    return Container(
        // Column is a vertical, linear layout.
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(20.0), child: const DroneData()),
            JoyStick(
                joystickController: joystickController,
                switchArmCallback: _switchArm,
                switchRecordCallback: _switchRecord)
          ],
        ));
  }
}

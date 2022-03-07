import 'dart:developer';

import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:droneapp/classes/DTO/ManualControlDTO.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:flutter/material.dart';

class JoystickButtons extends StatelessWidget {
  // Don't want the Analog stick to know about the singleton
  // More work to handle this, but less coupling with other classes
  final VoidCallback rotateLeft;
  final VoidCallback rotateRight;
  final VoidCallback resetRotation;

  final VoidCallback moveDown;
  final VoidCallback moveUp;
  final VoidCallback resetVertical;

  const JoystickButtons(
      {Key? key,
      required this.rotateLeft,
      required this.rotateRight,
      required this.resetRotation,
      required this.moveDown,
      required this.moveUp,
      required this.resetVertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padSize = size.width * 0.48;
    double btnSize = padSize * 0.25;
    return RotatedBox(
        quarterTurns: -1,
        child: PadButtonsView(
          size: padSize,
          backgroundPadButtonsColor: Colors.grey,
          buttonsPadding: 8,
          padButtonPressedCallback: _handleButtons,
          buttons: [
            PadButtonItem(
                index: 0,
                buttonIcon: Icon(
                  Icons.arrow_right,
                  size: btnSize,
                ),
                backgroundColor: Colors.lightBlue,
                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP]),
            PadButtonItem(
                index: 1,
                buttonIcon: Icon(
                  Icons.arrow_downward,
                  size: btnSize,
                ),
                backgroundColor: Colors.red,
                pressedColor: Colors.redAccent,
                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP]),
            PadButtonItem(
                index: 2,
                buttonIcon: Icon(
                  Icons.arrow_left,
                  size: btnSize,
                ),
                backgroundColor: Colors.lightBlue,
                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP]),
            PadButtonItem(
                index: 3,
                buttonIcon: Icon(
                  Icons.arrow_upward,
                  size: btnSize,
                ),
                backgroundColor: Colors.green,
                pressedColor: Colors.greenAccent,
                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP])
          ],
        ));
  }

  _handleButtons(int buttonIndex, Gestures gesture) {
    if (buttonIndex == 0) {
      // log("right");
      if (gesture == Gestures.TAPDOWN) {
        rotateRight();
      } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
        resetRotation();
      }
    } else if (buttonIndex == 1) {
      // log("down");
      if (gesture == Gestures.TAPDOWN) {
        moveDown();
      } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
        resetVertical();
      }
    } else if (buttonIndex == 2) {
      // log("left");
      if (gesture == Gestures.TAPDOWN) {
        rotateRight();
      } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
        resetRotation();
      }
    } else if (buttonIndex == 3) {
      // log("up");
      if (gesture == Gestures.TAPDOWN) {
        moveUp();
      } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
        resetVertical();
      }
    }
    // log(control.toString());
  }
}

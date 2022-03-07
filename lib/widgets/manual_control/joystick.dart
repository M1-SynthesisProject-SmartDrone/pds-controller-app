import 'dart:math' as math;
import 'dart:developer';

import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/widgets/drone_data_display/DroneData.dart';
import 'package:droneapp/widgets/util/ToastUtil.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import '../../classes/DroneCommunication.dart';

class JoyStick extends StatefulWidget {
  const JoyStick({Key? key}) : super(key: key);

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State {
  final DroneCommunication droneCommunication = DroneCommunication();
  DroneControl control = DroneControl();

  Color armButtonColor = Colors.red;
  Color recordButtonColor = Colors.red;

  void _switchArm() {
    setState(() {
      control.switchArm();
      if (control.isArmed == true) {
        armButtonColor = Colors.blue;
        droneCommunication.armDrone().then((void _) {
          armButtonColor = Colors.green;
          log("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Arming Drone : " + e.toString());
          armButtonColor = Colors.red;
          control.unArm();
          log("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        });
      } else {
        armButtonColor = Colors.blue;
        droneCommunication.disarmDrone().then((void _) {
          armButtonColor = Colors.red;
          log("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Arming Drone : " + e.toString());
          armButtonColor = Colors.green;
          control.arm();
          log("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        });
      }
    });
  }

  void _switchRecord() {
    setState(() {
      control.switchRecording();
      if (control.isRecording == true) {
        recordButtonColor = Colors.blue;
        droneCommunication.startRecording().then((void _) {
          recordButtonColor = Colors.green;
          log("control arm -> " + control.isRecording.toString());
          (context as Element).reassemble();
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Starting Record: " + e.toString());
          recordButtonColor = Colors.red;
          control.endRecord();
          log("control rec -> " + control.isRecording.toString());
          (context as Element).reassemble();
        });
      } else {
        recordButtonColor = Colors.blue;
        droneCommunication.endRecording().then((void _) {
          recordButtonColor = Colors.red;
          log("control arm -> " + control.isRecording.toString());
          (context as Element).reassemble();
        }).catchError((e) {
          ToastUtil.showToast(context, "Error while Ending Record: " + e.toString());
          recordButtonColor = Colors.green;
          control.startRecord();
          log("control rec -> " + control.isRecording.toString());
          (context as Element).reassemble();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void droneDirection(double degrees, double distance) {
      // log(degrees.toString() + " --- "+distance.toString() );
      control.setDirection(
          distance * math.cos((degrees * math.pi) / 180), distance * math.sin((degrees * math.pi) / 180));
      log(control.toString());
    }

    void droneController(int buttonIndex, Gestures gesture) {
      if (buttonIndex == 0) {
        log("right");
        if (gesture == Gestures.TAPDOWN) {
          control.rotateRight();
        } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
          control.resetRotation();
        }
      } else if (buttonIndex == 1) {
        log("down");
        if (gesture == Gestures.TAPDOWN) {
          control.moveDown();
        } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
          control.resetVertical();
        }
      } else if (buttonIndex == 2) {
        log("left");
        if (gesture == Gestures.TAPDOWN) {
          control.rotateRight();
        } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
          control.resetRotation();
        }
      } else if (buttonIndex == 3) {
        log("up");

        if (gesture == Gestures.TAPDOWN) {
          control.moveUp();
          log("push");
        } else if (gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP) {
          control.resetVertical();
          log("release");
        }
      }
      log(control.toString());
    }

    Size screenSize = MediaQuery.of(context).size;

    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Container(
        // Column is a vertical, linear layout.
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(20.0), child: DroneData(screenSize: screenSize)),
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                        quarterTurns: -1,
                        child: PadButtonsView(
                          backgroundPadButtonsColor: Colors.grey,
                          buttonsPadding: 8,
                          padButtonPressedCallback: droneController,
                          buttons: const [
                            PadButtonItem(
                                index: 0,
                                buttonIcon: Icon(
                                  Icons.arrow_right,
                                  size: 30,
                                ),
                                backgroundColor: Colors.lightBlue,
                                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP]),
                            PadButtonItem(
                                index: 1,
                                buttonIcon: Icon(
                                  Icons.arrow_downward,
                                  size: 30,
                                ),
                                backgroundColor: Colors.red,
                                pressedColor: Colors.redAccent,
                                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP]),
                            PadButtonItem(
                                index: 2,
                                buttonIcon: Icon(
                                  Icons.arrow_left,
                                  size: 30,
                                ),
                                backgroundColor: Colors.lightBlue,
                                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP]),
                            PadButtonItem(
                                index: 3,
                                buttonIcon: Icon(
                                  Icons.arrow_upward,
                                  size: 30,
                                ),
                                backgroundColor: Colors.green,
                                pressedColor: Colors.greenAccent,
                                supportedGestures: [Gestures.TAPDOWN, Gestures.LONGPRESSUP, Gestures.TAPUP])
                          ],
                        )),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: TextButton(
                              onPressed: _switchRecord,
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(recordButtonColor)),
                              child: const Text("Record")),
                        ),
                        RotatedBox(
                            quarterTurns: -1,
                            child: TextButton(
                                onPressed: _switchArm,
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
                    ),
                    const SizedBox(height: 50),
                    RotatedBox(
                        quarterTurns: -1,
                        child: JoystickView(
                          onDirectionChanged: droneDirection,
                          interval: const Duration(milliseconds: 100),
                        )),
                  ],
                ))
          ],
        ));
  }
}
import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/classes/Network/DroneControlSender.dart';
import 'package:droneapp/classes/Network/DroneDataReceiver.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/util/ToastUtil.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:flutter/painting.dart';
import '../classes/DroneCommunication.dart';
import '../main.dart';


class JoyStick extends StatefulWidget {
  JoyStick({Key? key}) : super(key: key);


  @override
  _JoystickState createState() => _JoystickState();
}


class _JoystickState extends State{


  DroneCommunication droneCommunication= DroneCommunication();
  DroneControl control = DroneControl();
  double PI = 3.141592653589793238;
  DroneControlSender sender = DroneControlSender();
  DroneDataReceiver receiver = DroneDataReceiver();


  Color armButtonColor = Colors.red;
  Color recordButtonColor = Colors.red;


  @override
  void initState() {
    super.initState();
    sender.sendDroneControl();
    //receiver.updateDroneData();
    droneCommunication.updateDroneData();
  }

  void _switchArm(){
    setState(() {
      //control.switchArm();
      if (control.isArmed == false) {
        armButtonColor = Colors.blue;
        droneCommunication.armDrone()
            .then((void _) {
              armButtonColor = Colors.green;
              print("control arm -> " + control.isArmed.toString());
              (context as Element).reassemble();
            })
            .catchError((e) {
          ToastUtil.showToast(context, "Error while Arming Drone : " + e.toString());
          armButtonColor = Colors.red;
          control.unArm();
          print("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        });
      }
      else {
        armButtonColor = Colors.blue;
        droneCommunication.disarmDrone()
            .then((void _) {
          armButtonColor = Colors.red;
          control.unArm();
          print("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        })
            .catchError((e) {
          ToastUtil.showToast(context, "Error while Arming Drone : " + e.toString());
          armButtonColor = Colors.green;
          control.arm();
          print("control arm -> " + control.isArmed.toString());
          (context as Element).reassemble();
        });
      }
    });
  }

  void _switchRecord(){
    setState(() {
      control.switchRecording();
      if (control.isRecording == true) {
        recordButtonColor = Colors.blue;
        droneCommunication.startRecording()
            .then((void _) {
          recordButtonColor = Colors.green;
          print("control arm -> " + control.isRecording.toString());
          (context as Element).reassemble();
        })
            .catchError((e) {
          ToastUtil.showToast(context, "Error while Starting Record: " + e.toString());
          recordButtonColor = Colors.red;
          control.endRecord();
          print("control rec -> " + control.isRecording.toString());
          (context as Element).reassemble();
        });
      }
      else {
        recordButtonColor = Colors.blue;
        droneCommunication.endRecording()
            .then((void _) {
          recordButtonColor = Colors.red;
          print("control arm -> " + control.isRecording.toString());
          (context as Element).reassemble();
        })
            .catchError((e) {
          ToastUtil.showToast(context, "Error while Ending Record: " + e.toString());
          recordButtonColor = Colors.green;
          control.startRecord();
          print("control rec -> " + control.isRecording.toString());
          (context as Element).reassemble();
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    void droneDirection(
        double degrees, double distance){
      // print(degrees.toString() + " --- "+distance.toString() );
      control.setDirection(distance*cos( (degrees*PI)/180 ), distance*sin( (degrees*PI)/180));
      print(control);
    }



    void droneController(int buttonIndex, Gestures gesture) {
      if(buttonIndex == 0){
        print("right");
        if(gesture == Gestures.TAPDOWN){
          control.rotateRight();
        }
        else if(gesture == Gestures.LONGPRESSUP || gesture == Gestures.TAPUP ){
          control.resetRotation();
        }
      }
      else if(buttonIndex == 1){
        print("down");
        if(gesture == Gestures.TAPDOWN){
          control.moveDown();
        }
        else if(gesture == Gestures.LONGPRESSUP|| gesture == Gestures.TAPUP){
          control.resetVertical();
        }
      }
      else if(buttonIndex == 2){
        print("left");
        if(gesture == Gestures.TAPDOWN){
          control.rotateRight();
        }
        else if(gesture == Gestures.LONGPRESSUP|| gesture == Gestures.TAPUP){
          control.resetRotation();

        }
      }
      else if(buttonIndex == 3){
        print("up");

        if(gesture == Gestures.TAPDOWN){
          control.moveUp();
          print("push");

        }
        else if(gesture == Gestures.LONGPRESSUP|| gesture == Gestures.TAPUP){
          control.resetVertical();
          print("release");
        }
      }
      print(control);
    }
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Container(
      // Column is a vertical, linear layout.
        color: Colors.white,
        child:Row(
          children : [
            const SizedBox(width: 20),// <-- Set height
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 300,
                  child: Row(
                    children:  [
                      SizedBox(width: 50),// <-- Set height

                      RotatedBox(quarterTurns: -1, child: Text('Altitude : ' + control.altitude.toString(), style: TextStyle(fontSize: 15, color: Colors.black),)),
                      RotatedBox(quarterTurns: -1, child: Text("Vitesse sol : " + control.speed.toString(), style: TextStyle(fontSize: 15, color: Colors.black))),
                      RotatedBox(quarterTurns: -1, child: Text("Position : " + control.position.toString(),style: TextStyle(fontSize: 15, color: Colors.black))),

                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),

                ),

              ],
            ),
            Column(

              children: [
                SizedBox(height: 70),// <-- Set height
                RotatedBox(quarterTurns: -1, child: PadButtonsView(
                  backgroundPadButtonsColor: Colors.grey,
                  buttonsPadding: 8,
                  padButtonPressedCallback: droneController,
                  buttons: const [
                    PadButtonItem(
                        index: 0,
                        buttonIcon: Icon(Icons.arrow_right, size: 30,),
                        backgroundColor: Colors.lightBlue,
                        supportedGestures: [
                          Gestures.TAPDOWN,
                          Gestures.LONGPRESSUP,
                          Gestures.TAPUP
                        ]

                    ),
                    PadButtonItem(
                        index: 1,
                        buttonIcon: Icon(Icons.arrow_downward, size: 30,),
                        backgroundColor: Colors.red,
                        pressedColor: Colors.redAccent,
                        supportedGestures: [
                          Gestures.TAPDOWN,
                          Gestures.LONGPRESSUP,
                          Gestures.TAPUP
                        ]
                    ),
                    PadButtonItem(
                        index: 2,
                        buttonIcon: Icon(Icons.arrow_left, size: 30,),
                        backgroundColor: Colors.lightBlue,
                        supportedGestures: [
                          Gestures.TAPDOWN,
                          Gestures.LONGPRESSUP,
                          Gestures.TAPUP
                        ]
                    ),
                    PadButtonItem(
                        index: 3,
                        buttonIcon: Icon(Icons.arrow_upward, size: 30,),
                        backgroundColor: Colors.green,
                        pressedColor: Colors.greenAccent,
                        supportedGestures: [
                          Gestures.TAPDOWN,
                          Gestures.LONGPRESSUP,
                          Gestures.TAPUP
                        ]

                    )

                  ],
                )),
                const SizedBox(height: 100),
                Row(
                  children: [
                    RotatedBox(quarterTurns: -1, child:TextButton(onPressed: _switchRecord,  style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(recordButtonColor)
                    ),child: new Text("Record")),),
                    RotatedBox(quarterTurns: -1, child:TextButton(onPressed: _switchArm,
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(armButtonColor)
                        ),child: new Text("Arm"))),
                    RotatedBox(quarterTurns: -1, child:TextButton(onPressed: (){ Navigator.pop(context); }, child: Icon(Icons.arrow_back_sharp))),

                  ],
                ),// <-- Set height
                const SizedBox(height: 100), // <-- Set height
                RotatedBox(quarterTurns: -1, child: JoystickView(
                  onDirectionChanged: droneDirection,
                  interval: Duration(milliseconds: 100),
                )),

              ],
            )],
        )


    );
  }


}


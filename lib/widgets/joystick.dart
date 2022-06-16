import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'dart:ui';

import 'package:control_pad/models/gestures.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/classes/Network/DroneControlSender.dart';
import 'package:droneapp/classes/Network/DroneDataReceiver.dart';
import 'package:droneapp/widgets/DroneDataWidget.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/util/ToastUtil.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:flutter/painting.dart';
import '../classes/CommunicationAPI/responses/DroneData.dart';
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
  bool stopLoops = false;


  Color armButtonColor = Colors.red;
  Color recordButtonColor = Colors.red;


  @override
  void initState() {
    super.initState();
    sender.sendDroneControl();
    //updateDroneData();
  }

/*  Future<void> updateDroneData() async {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if(control.isArmed){
        DroneData data = await droneCommunication.getDroneData();
        setState(() {
          control.altitude = data.relativeAlt;
          control.speed = sqrt( pow(data.vx, 2) + pow(data.vy, 2) + pow(data.vz, 2) );
          control.position = (data.lat/10000000).toString() +" "+ (data.lon/10000000).toString();
        });
      }
      else{
        setState(() {
          control.altitude = 0;
          control.speed = 0.0;
          control.position="unknown";
        });

      }
    });
  }*/

  void _switchArm(){
    setState(() {
      //control.switchArm();
      armButtonColor = Colors.blue;
      print(control.isArmed);
      if (control.isArmed == false) {
        droneCommunication.armDrone()
            .then((void _) {
          armButtonColor = Colors.green;
          control.arm();
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
      //control.switchRecording();
      if (control.isRecording == false) {
        recordButtonColor = Colors.blue;
        droneCommunication.startRecording()
            .then((void _) {
          print("truc");
          control.startRecord();
          recordButtonColor = Colors.green;
          print("control arm true-> " + control.isRecording.toString());
          (context as Element).reassemble();
        })
            .catchError((e) {
          ToastUtil.showToast(context, "Error while Starting Record: " + e.toString());
          recordButtonColor = Colors.red;
          control.endRecord();
          print("control rec false -> " + control.isRecording.toString());
          (context as Element).reassemble();
        });
      }
      else {
        recordButtonColor = Colors.blue;
        droneCommunication.endRecording()
            .then((void _) {
          recordButtonColor = Colors.red;
          control.endRecord();
          print("control arm true -> " + control.isRecording.toString());
          (context as Element).reassemble();
        })
            .catchError((e) {
          ToastUtil.showToast(context, "Error while Ending Record: " + e.toString());
          recordButtonColor = Colors.green;
          control.startRecord();
          print("control rec fakse-> " + control.isRecording.toString());
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
            DroneDataWidget(),
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
                    RotatedBox(quarterTurns: -1, child:TextButton(onPressed: (){
                      sender.endSendDroneControl();
                      Navigator.pop(context);

                      }, child: Icon(Icons.arrow_back_sharp))),

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


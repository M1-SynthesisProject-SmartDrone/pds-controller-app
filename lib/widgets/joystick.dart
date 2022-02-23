import 'package:control_pad/models/pad_button_item.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import '../main.dart';


class JoyStick extends StatefulWidget {
  JoyStick({Key? key}) : super(key: key);


  @override
  _JoystickState createState() => _JoystickState();
}


class _JoystickState extends State{
  DroneControl control = DroneControl();

  void _increment(){
    setState(() {
      control.position++;
    });
  }

  void _decrement(){
    setState(() {
      control.position--;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                new RotatedBox(quarterTurns: -1, child: PadButtonsView(
                  backgroundPadButtonsColor: Colors.grey,
                  buttonsPadding: 8,
                  buttons: [
                    PadButtonItem(
                      index: 0,
                      buttonIcon: Icon(Icons.arrow_right, size: 30,),
                      backgroundColor: Colors.lightBlue,
                    ),
                    PadButtonItem(
                        index: 1,
                        buttonIcon: Icon(Icons.arrow_downward, size: 30,),
                        backgroundColor: Colors.red,
                        pressedColor: Colors.redAccent
                    ),
                    PadButtonItem(
                      index: 2,
                      buttonIcon: Icon(Icons.arrow_left, size: 30,),
                      backgroundColor: Colors.lightBlue,
                    ),
                    PadButtonItem(
                        index: 3,
                        buttonIcon: Icon(Icons.arrow_upward, size: 30,),
                        backgroundColor: Colors.green,
                        pressedColor: Colors.greenAccent
                    )

                  ],
                )),
                SizedBox(height: 100),
                Row(
                  children: [
                    new RotatedBox(quarterTurns: -1, child:ElevatedButton(onPressed: _increment, child: new Text("Record"))),
                    new RotatedBox(quarterTurns: -1, child:ElevatedButton(onPressed: _decrement, child: new Text("Arm"))),
                    new RotatedBox(quarterTurns: -1, child:ElevatedButton(onPressed: (){ Navigator.pop(context); }, child: Icon(Icons.arrow_back_sharp))),

                  ],
                ),// <-- Set height
                SizedBox(height: 100), // <-- Set height
                new RotatedBox(quarterTurns: -1, child: JoystickView()),

              ],
            )],
        )


    );
  }


}


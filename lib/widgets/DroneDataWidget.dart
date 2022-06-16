import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/CommunicationAPI/responses/DroneData.dart';
import '../classes/DroneCommunication.dart';
import '../classes/DroneControl.dart';

class DroneDataWidget extends StatefulWidget{


  @override
  _DroneDataWidget createState() => _DroneDataWidget();

}

class _DroneDataWidget extends State{

  DroneCommunication droneCommunication= DroneCommunication();
  DroneControl control = DroneControl();
  bool stopLoops = false;

  @override
  void dispose() {
    super.dispose();
    stopLoops = true;
  }

@override
  void initState() {
    super.initState();
    updateDroneData();
  }


  Future<void> updateDroneData() async {
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
      if(stopLoops){
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              RotatedBox(quarterTurns: -1, child: Text("Vitesse sol : " + control.speed.toStringAsFixed(2), style: TextStyle(fontSize: 15, color: Colors.black))),
              RotatedBox(quarterTurns: -1, child: Text("Position : " + control.position.toString(),style: TextStyle(fontSize: 15, color: Colors.black))),

            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
          ),

        ),

      ],
    );
  }
  
}
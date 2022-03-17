import 'dart:async';
import 'dart:isolate';

import 'package:droneapp/classes/CommunicationAPI/requests/DroneControlRequest.dart';
import 'package:droneapp/classes/DroneCommunication.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:flutter/material.dart';

class DroneControlSender {

  late DroneControl control;
  late DroneCommunication communication;


  DroneControlSender() {
    communication = DroneCommunication();
    control = DroneControl();
  }

  Future<void> sendDroneControl() async {
    print("starting sendDroneControl");
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      //print("control := " + control.isArmed.toString());
      print("entering in timer periodic sendDroneControl");

      if(control.isArmed){
        print("starting send");
        DroneControlRequest req = DroneControlRequest(control.x, control.y ,control.z ,control.r);
        communication.sendDroneControl(req);
      }

    });
  }

}
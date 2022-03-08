import 'dart:async';
import 'dart:isolate';

import 'package:droneapp/classes/CommunicationAPI/requests/DroneControlRequest.dart';
import 'package:droneapp/classes/DroneCommunication.dart';
import 'package:droneapp/classes/DroneControl.dart';

class DroneControlSender {

  late DroneControl control;
  late DroneCommunication communication;


  DroneControlSender() {
    communication = DroneCommunication();
    control = DroneControl();
  }

  Future<void> sendDroneControl() async {
    print("truc");
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      //print("control := " + control.isArmed.toString());
      if(control.isArmed){
        DroneControlRequest req = DroneControlRequest(control.x, control.y ,control.z ,control.r);
        communication.sendDroneControl(req);
      }

    });
  }

}
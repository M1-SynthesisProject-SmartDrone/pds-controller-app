import 'dart:async';

import '../DroneCommunication.dart';
import '../DroneControl.dart';

class DroneDataReceiver {
  late DroneControl control;
  late DroneCommunication communication;


  DroneDataReceiver() {
    communication = DroneCommunication();
    control = DroneControl();
  }

  Future<void> updateDroneData() async {
    // while(true){
    //   await communication.updateDroneData();
    //
    // }

    Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      //print("control := " + control.isArmed.toString());
      if(control.isArmed){
          await communication.updateDroneData();
          print("test");
      }

    });
  }

}
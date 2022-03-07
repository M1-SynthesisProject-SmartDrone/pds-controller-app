import 'package:droneapp/classes/DTO/DroneDataDTO.dart';
import 'package:droneapp/widgets/drone_data_display/DroneBattery.dart';
import 'package:droneapp/widgets/drone_data_display/DronePosition.dart';
import 'package:droneapp/widgets/drone_data_display/DroneRotation.dart';
import 'package:flutter/material.dart';

import 'DroneSpeed.dart';

/// This widget display all drone-related data (speed, position, etc.)
class DroneData extends StatefulWidget {
  const DroneData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DroneDataState();
}

class _DroneDataState extends State<DroneData> {
  DroneDataDTO dataDTO = DroneDataDTO();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.8,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              RotatedBox(
                  quarterTurns: -1,
                  child: DronePosition(latitude: dataDTO.latitude, longitude: dataDTO.longitude, altitude: dataDTO.altitude)),
              RotatedBox(quarterTurns: -1, child: DroneSpeed(vx: dataDTO.vx, vy: dataDTO.vy, vz: dataDTO.vz)),
              RotatedBox(quarterTurns: -1, child: DroneRotation(rotation: dataDTO.yawRotation)),
              RotatedBox(quarterTurns: -1, child: DroneBattery(remainingBattery: dataDTO.batteryRemaining),)
            ],
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        ),
      ],
    );
  }

  updateState(DroneDataDTO dataDao) {
    setState(() {
      dataDTO = dataDao;
    });
  }
}

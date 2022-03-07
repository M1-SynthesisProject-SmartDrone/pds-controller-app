import 'package:droneapp/widgets/drone_data_display/DroneBattery.dart';
import 'package:droneapp/widgets/drone_data_display/DronePosition.dart';
import 'package:droneapp/widgets/drone_data_display/DroneRotation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DroneSpeed.dart';

/// This widget display all drone-related data (speed, position, etc.)
class DroneData extends StatefulWidget {
  final Size screenSize;

  const DroneData({Key? key, required this.screenSize}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DroneDataState();
}

class _DroneDataState extends State<DroneData> {
  // final

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: widget.screenSize.height * 0.8,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: const [
              RotatedBox(
                  quarterTurns: -1,
                  child: DronePosition(latitude: "00.00000000", longitude: "00.00000000", altitude: "00.00000000")),
              RotatedBox(quarterTurns: -1, child: DroneSpeed(vx: 0.0, vy: 0.0, vz: 0.0)),
              RotatedBox(quarterTurns: -1, child: DroneRotation(rotation: 0)),
              RotatedBox(quarterTurns: -1, child: DroneBattery(remainingBattery: 50),)
            ],
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        ),
      ],
    );
  }
}

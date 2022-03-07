import 'package:flutter/material.dart';

class DronePosition extends StatelessWidget {
  final String latitude;
  final String longitude;
  final String altitude;

  const DronePosition({Key? key, required this.latitude, required this.longitude, required this.altitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Position: lat=$latitude, lon=$longitude, alt=$altitude",
        style: const TextStyle(fontSize: 15, color: Colors.black));
  }
}

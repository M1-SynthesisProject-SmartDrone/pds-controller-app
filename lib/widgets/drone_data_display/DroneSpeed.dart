import 'package:flutter/material.dart';

class DroneSpeed extends StatelessWidget {
  final double vx;
  final double vy;
  final double vz;

  const DroneSpeed({Key? key, required this.vx, required this.vy, required this.vz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Speed: Vx=$vx, Vy=$vy, Vz=$vz",
        style: const TextStyle(fontSize: 15, color: Colors.black));
  }
}

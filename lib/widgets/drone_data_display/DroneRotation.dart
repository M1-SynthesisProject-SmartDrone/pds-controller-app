import 'package:flutter/material.dart';

class DroneRotation extends StatelessWidget {
  final int rotation;

  const DroneRotation({Key? key, required this.rotation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Rotation: $rotation°",
        style: const TextStyle(fontSize: 15, color: Colors.black));
  }
}

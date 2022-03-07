import 'package:flutter/material.dart';

class DroneBattery extends StatelessWidget {
  final int remainingBattery;

  const DroneBattery({Key? key, required this.remainingBattery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Remaining battery: $remainingBattery %",
        style: const TextStyle(fontSize: 15, color: Colors.black));
  }
}

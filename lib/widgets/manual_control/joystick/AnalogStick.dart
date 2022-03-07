import 'dart:math' as math;

import 'package:control_pad/control_pad.dart';
import 'package:flutter/material.dart';

class AnalogStick extends StatelessWidget {
  final Function(double x, double y) updateStickCallback;

  const AnalogStick({Key? key, required this.updateStickCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padSize = size.width * 0.48;
    return RotatedBox(
        quarterTurns: -1,
        child: JoystickView(
          size: padSize,
          onDirectionChanged: (double degrees, double distance) {
            // Update the parent with the right values
            double x = distance * math.cos((degrees * math.pi) / 180);
            double y = distance * math.sin((degrees * math.pi) / 180);
            updateStickCallback(x, y);
          },
          interval: const Duration(milliseconds: 100),
        ));
  }
}

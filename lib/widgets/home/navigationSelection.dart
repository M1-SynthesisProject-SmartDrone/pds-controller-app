import 'package:droneapp/widgets/home/connexion.dart';
import 'package:droneapp/widgets/manual_control/joystick.dart';
import 'package:droneapp/widgets/automatic_control/trajet.dart';
import 'package:droneapp/widgets/automatic_control/trajetSelection.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
class NavigationSelection extends StatelessWidget {
  const NavigationSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return MaterialApp(
      // Column is a vertical, linear layout.
      home: Scaffold(
        appBar : AppBar(title: const Text('Drone Controller')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => JoyStick()));
                      },
                      child: const Text('Manual control'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TrajetList()));

                      },
                      child: const Text('Automatic control'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Disconnect'),
                    )


                  ],
                )
            )

          ],
        ),
      ),


    );
  }
}
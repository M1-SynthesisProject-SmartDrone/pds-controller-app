import 'package:droneapp/classes/DroneCommunication.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/joystick.dart';
import 'package:droneapp/widgets/trajet.dart';
import 'package:droneapp/widgets/trajetSelection.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class NavigationSelection extends StatelessWidget {
  const NavigationSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    DroneCommunication communication = DroneCommunication();

    return MaterialApp(
      // Column is a vertical, linear layout.
      home: Scaffold(
        appBar : AppBar(title: Text('Drone Controller')),
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
                      child: Text('Controle manuel'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TrajetList()));

                      },
                      child: Text('Controle automatique'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),
                      onPressed: () {
                        communication.networkControl.close();
                        Navigator.pop(context);
                      },
                      child: Text('Deconnexion'),
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
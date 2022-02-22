import 'package:droneapp/widgets/TrajetArguments.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/trajet.dart';
import 'package:droneapp/widgets/trajetSelection.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class Trajet extends StatelessWidget {
  const Trajet({Key? key}) : super(key: key);

  static const routename = '/trajet';

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.

    final args = ModalRoute.of(context)!.settings.arguments as TrajetArguments;

    return MaterialApp(
      // Column is a vertical, linear layout.
      home: Scaffold(
        appBar: AppBar(title: Text('Drone Controller')),
        body: Column(
          children: [

            Container(
                height: 600,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("Trajet ${args.id}")



                  ],
                )
            )

          ],
        ),
      ),


    );
  }
}
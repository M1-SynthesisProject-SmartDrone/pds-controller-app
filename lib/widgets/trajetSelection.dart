import 'package:droneapp/widgets/TrajetArguments.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/trajet.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TrajetList extends StatelessWidget {
  const TrajetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.

    var items= List<String>.generate(20, (i) => 'Trajet $i');


    return MaterialApp(
      routes: {Trajet.routename : (context) => const Trajet()},
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Drone Controller"),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {

            return ListTile(
              title: Text(items[index]),
              onTap: (){
                Navigator.pushNamed(context, Trajet.routename, arguments: TrajetArguments(index));
              },
            );

          },
        ),
      ),
    );
  }
}
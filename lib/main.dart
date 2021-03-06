import 'package:droneapp/widgets/connexion.dart';
import 'package:flutter/material.dart';


class Connection extends StatelessWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return MaterialApp(
      // Column is a vertical, linear layout.
      home: Scaffold(
        appBar: AppBar(title: const Text("Drone Controller"),),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Connexion()
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const Material(
      child: Connection(),
    ),
  );
}
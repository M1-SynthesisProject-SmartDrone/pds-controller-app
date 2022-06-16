import 'package:droneapp/classes/CommunicationAPI/responses/PathListAnswer.dart';
import 'package:droneapp/classes/DroneCommunication.dart';
import 'package:droneapp/widgets/TrajetArguments.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/trajet.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TrajetList extends StatefulWidget {
  const TrajetList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrajetSelectionState();
}

class TrajetSelectionState extends State{

  Future<PathListAnswer> getTrajets() async {
    DroneCommunication communication = DroneCommunication();

    PathListAnswer paths = await communication.getPathList();
    return paths;
  }


  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.

    return FutureBuilder(
      future: getTrajets(),
      builder: (BuildContext context, AsyncSnapshot<PathListAnswer> snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none: return new Text('Press button to start');
          case ConnectionState.waiting: return new Text('Awaiting result...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else {
              PathListAnswer paths = snapshot.data as PathListAnswer;
              return MaterialApp(
                routes: {Trajet.routename: (context) => const Trajet()},
                home: Scaffold(
                  appBar: AppBar(
                    title: const Text("Drone Controller"),
                  ),
                  body: ListView.builder(
                    itemCount: paths.pathList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(paths.pathList[index].name),
                          subtitle: Text(paths.pathList[index].date),
                          onTap: () {
                            Navigator.pushNamed(context, Trajet.routename,
                                arguments: paths.pathList[index].id);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }
        }
      },
    );

  }

}



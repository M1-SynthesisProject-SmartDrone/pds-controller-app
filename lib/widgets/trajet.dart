import 'dart:async';

import 'package:droneapp/classes/CommunicationAPI/responses/OnePathAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathInfosResponse.dart';
import 'package:droneapp/classes/DroneCommunication.dart';
import 'package:droneapp/widgets/AutomaticPilotView.dart';
import 'package:droneapp/widgets/TrajetArguments.dart';
import 'package:droneapp/widgets/connexion.dart';
import 'package:droneapp/widgets/trajet.dart';
import 'package:droneapp/widgets/trajetSelection.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main.dart';

class Trajet extends StatefulWidget {
  const Trajet({Key? key}) : super(key: key);

  static const routename = '/trajet';

  @override
  State<StatefulWidget> createState() => TrajetState();

}

class TrajetState extends State{

  Future<OnePathAnswer> getOneTrajet(int tripid) async {
    DroneCommunication communication = DroneCommunication();

    OnePathAnswer path = await communication.getOnePath(tripid);
    return path;
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
      future: getOneTrajet(args),
      builder: (BuildContext context, AsyncSnapshot<OnePathAnswer> snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none: return new Text('Press button to start');
          case ConnectionState.waiting: return new Text('Awaiting result...');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              OnePathAnswer data = snapshot.data as OnePathAnswer;
              return MaterialApp(
                routes: {Trajet.routename: (context) => const Trajet()},
                home: Scaffold(
                  appBar: AppBar(
                    title: const Text("Drone Controller"),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text("id trajet :" + data.id.toString()),
                              Text("nom trajet :" + data.name.toString()),
                              Text("date de création :" + data.date.toString()),
                              Text("nombre de Points :" + data.nbPoints.toString()),
                              Text("nombre de Checkpoints :" + data.nbCheckpoints.toString()),
                              Text("latitude de départ:" + data.lat.toString()),
                              Text("longitude de départ:" + data.long.toString()),
                              Text("altitude de départ:" + data.alt.toString()),

                              TextButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                                ),
                                onPressed: () {
                                  DroneCommunication communication = DroneCommunication();
                                  communication.launchPath(data.id);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AutomaticPilotView()));

                                },
                                child: Text('Lancer le trajet !'),
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
      },
    );
  }
}

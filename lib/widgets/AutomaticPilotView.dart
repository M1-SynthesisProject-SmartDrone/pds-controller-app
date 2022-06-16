import 'dart:async';

import 'package:droneapp/widgets/util/ToastUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/CommunicationAPI/responses/AutopilotInfosResponse.dart';
import '../classes/DroneCommunication.dart';

class AutomaticPilotView extends StatefulWidget{
  const AutomaticPilotView({Key? key}) : super(key: key);

  @override
  AutomaticPilotState createState() => AutomaticPilotState();

}

class AutomaticPilotState extends State {
  DroneCommunication droneCommunication= DroneCommunication();
  double latitude = 0;
  double longitude= 0;
  int altitude= 0;

  @override
  void initState() {
    super.initState();
    updateAutoPilotData();
  }


  Future<void> updateAutoPilotData() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      AutopilotInfosResponse data = await droneCommunication.getAutoPilotInfos();
      if(data.running && (mounted) ){
        setState(() {
          altitude = data.alt;
          latitude = data.lat/10000000;
          longitude = data.lon/10000000;
        });

      }
      else {
          timer.cancel();
          ToastUtil.showToast(context, "Trip Finished Successfully !");
          Navigator.pop(context);

      }
      }
    );
    //Navigator.pop(context);
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Drone Controller"),
          ),
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 500,
                height: 300,
                child: Column(
                  children:  [
                    Text('Automatic Trip Launched !', style: TextStyle(fontSize: 18, color: Colors.black)),
                    SizedBox(width: 500),// <-- Set height
                    Text('Latitude : ' + latitude.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                    Text('Longitude : ' + longitude.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                    Text('Altitude : ' + altitude.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                  ],
                ),


              ),

            ],
          )
    )

    );
  }

}
import 'package:droneapp/classes/NetworkControl.dart';
import 'package:droneapp/widgets/navigationSelection.dart';
import 'package:flutter/material.dart';

import '../classes/DroneCommunication.dart';

class Connexion extends StatelessWidget{

  Connexion({Key? key}) : super(key: key);

  final ipText = TextEditingController();
  final portText = TextEditingController();
  final DroneCommunication droneCommunication= DroneCommunication();
  @override
  Widget build(BuildContext context) {

    return Container(
        alignment: Alignment.center,
        width: 300,
        child : Column(

          children: [

            Text('Entrer l\'IP et le port du serveur distant', style: TextStyle(fontSize: 15, color: Colors.black),),
            TextField(
              obscureText: false,
              controller: ipText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adresse IP',
              ),
            ),
            TextField(
              obscureText: false,
              controller: portText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Port',
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
              ),
              onPressed: () {
                print(portText.text);

                bool isConnected = droneCommunication.connect(ipText.text, portText.text);
                if(isConnected){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationSelection()));

                }

              },
              child: Text('Se connecter'),
            )

          ],
        ),
      );
    // TODO: implement build
  }
  
}
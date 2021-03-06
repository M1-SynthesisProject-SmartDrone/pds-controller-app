import 'package:droneapp/classes/NetworkControl.dart';
import 'package:droneapp/widgets/navigationSelection.dart';
import 'package:droneapp/widgets/util/ToastUtil.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

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

            const Text('Enter the IP address of the server', style: TextStyle(fontSize: 15, color: Colors.black),),
            TextField(
              obscureText: false,
              controller: ipText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'IP address',
              ),
            ),
            TextField(
              obscureText: false,
              controller: portText,
              decoration: const InputDecoration(
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
                developer.log(portText.text);
                droneCommunication.connect(ipText.text, portText.text)
                  .then((void _) => Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationSelection())))
                  .catchError((e) => ToastUtil.showToast(context, "Error while connecting : " + e.toString()));
              },
              child: const Text('Connect'),
            )
          ],
        ),
      );
  }
  
}
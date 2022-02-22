import 'package:droneapp/widgets/navigationSelection.dart';
import 'package:flutter/material.dart';

class Connexion extends StatelessWidget{

  const Connexion({Key? key}) : super(key: key);

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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adresse IP',
              ),
            ),
            TextField(
              obscureText: false,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationSelection()));
              },
              child: Text('Se connecter'),
            )

          ],
        ),
      );
    // TODO: implement build
  }
  
}
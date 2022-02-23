import 'dart:io';

import 'package:droneapp/classes/CommunicationAPI/AnswerRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/RequestImpl.dart';
import 'package:droneapp/classes/CommunicationAPI/RequestTypes.dart';
import 'package:droneapp/classes/CommunicationAPI/StartRequest.dart';
import 'package:droneapp/classes/NetworkControl.dart';
import 'package:gson/gson.dart';

import 'CommunicationAPI/Request.dart';

class DroneCommunication{

  late NetworkControl networkControl;

  DroneCommunication();

  bool connect(String address, String port) {

    InternetAddress addressval = InternetAddress(address, type: InternetAddressType.any);
    int portval = int.parse(port);

    networkControl = NetworkControl(addressval, portval);
    Future<bool> isConnected = networkControl.connect();
    return true;
  }

}
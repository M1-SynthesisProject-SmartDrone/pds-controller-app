import 'dart:convert';
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

  Future<bool> connect(String address, String port) async {

    InternetAddress addressval = InternetAddress(address, type: InternetAddressType.any);
    int portval = int.parse(port);

    networkControl = NetworkControl(addressval, portval);
    await networkControl.connect();

    Object val = StartRequest(true);

    Request request = RequestImpl(RequestType.STARTDRONE, jsonEncode(val));


    print(request.getRequest());

    networkControl.sendData(request);
    Request req = networkControl.getData();

    AnswerRequest answer = AnswerRequest(req);

    return answer.validated;
  }

}
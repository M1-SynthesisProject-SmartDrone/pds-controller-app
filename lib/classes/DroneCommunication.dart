import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:droneapp/classes/CommunicationAPI/requests/AckRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';
import 'package:droneapp/classes/NetworkControl.dart';

class DroneCommunication {
  late NetworkControl networkControl;

  DroneCommunication();

  /// Send a acknowledgement message to the server and waits for the response
  /// Does not return anything, but can throw errors if connection is not well made
  Future<void> connect(String address, String port) async {
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();

    Request request = AckRequest();
    developer.log("Request : " + request.toJsonString());

    networkControl.sendRequest(request);
    Response response = await networkControl.receiveResponse();
    if (response.responseType != ResponseTypes.ANSWER) {
      return Future.error("error");
    }
    AnswerResponse answer = response as AnswerResponse;
    if (!answer.validated) {
      // Should never happen
      return Future.error("Server does not validate the acknowledgement");
    }
  }
}

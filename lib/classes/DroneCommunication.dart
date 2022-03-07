import 'dart:developer' as developer;

import 'package:droneapp/classes/CommunicationAPI/requests/AckRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RecordRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/StartDroneRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';
import 'package:droneapp/classes/Network/NetworkControl.dart';

class DroneCommunication {
  late NetworkControl networkControl;

  static final DroneCommunication _droneCommunication = DroneCommunication._internal();

  factory DroneCommunication() {
    return _droneCommunication;
  }

  DroneCommunication._internal() {
    networkControl = NetworkControl();
  }

  /// Send a acknowledgement message to the server and waits for the response
  /// Does not return anything, but can throw errors if connection is not well made
  Future<void> connect(String address, String port) async {
    await networkControl.bind(address, int.parse(port));
    try {
      Request request = AckRequest();
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.ANSWER) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      developer.log("Error while ack", error: e);
      networkControl.close();
      return Future.error(e.toString());
    }
  }

  Future<void> armDrone() async {
    try {
      Request request = StartDroneRequest(true);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.ANSWER) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }

  Future<void> disarmDrone() async {
    try {
      Request request = StartDroneRequest(false);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.ANSWER) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }

  Future<void> startRecording() async {
    try {
      Request request = RecordRequest(true);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.ANSWER) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }

  Future<void> endRecording() async {
    try {
      Request request = RecordRequest(false);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.ANSWER) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }
}

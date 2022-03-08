import 'dart:developer' as developer;

import 'package:droneapp/classes/CommunicationAPI/requests/AckRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RecordRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/StartDroneRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';
import 'package:droneapp/classes/DroneControl.dart';
import 'package:droneapp/classes/NetworkControl.dart';

import 'CommunicationAPI/requests/DroneControlRequest.dart';
import 'CommunicationAPI/responses/DroneData.dart';

class DroneCommunication {
  late NetworkControl networkControl;
  late String address;
  late String port;
  late DroneControl control;

  static final DroneCommunication _droneCommunication = DroneCommunication._internal();

  factory DroneCommunication(){
    return _droneCommunication;
  }

  DroneCommunication._internal();

  /// Send a acknowledgement message to the server and waits for the response
  /// Does not return anything, but can throw errors if connection is not well made
  Future<void> connect(String address, String port) async {
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      Request request = AckRequest();
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      this.address = address;
      this.port = port;
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
    } finally {
      networkControl.close();
    }
  }

  Future<void> armDrone() async{
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      Request request = StartDroneRequest(true);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      this.address = address;
      this.port = port;
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
    } finally {
      networkControl.close();
    }
  }

  Future<void> disarmDrone() async{
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      Request request = StartDroneRequest(false);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      this.address = address;
      this.port = port;
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
    } finally {
      networkControl.close();
    }
  }

  Future<void> startRecording() async{
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      Request request = RecordRequest(true);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      this.address = address;
      this.port = port;
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
    } finally {
      networkControl.close();
    }
  }

  Future<void> endRecording() async{
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      Request request = RecordRequest(false);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      this.address = address;
      this.port = port;
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
    } finally {
      networkControl.close();
    }
  }

  Future<void> sendDroneControl(DroneControlRequest control) async{
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      developer.log("Request : " + control.toJsonString());
      networkControl.sendRequest(control);
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    } finally {
      networkControl.close();
    }
  }


  Future<void> updateDroneData() async{
    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();
    try {
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      /*this.address = address;
      this.port = port;
      if (response.responseType != ResponseTypes.DRONE_DATA) {
        return Future.error("error");
      }
      DroneData data = response as DroneData;
      DroneControl control = DroneControl();
      control.altitude = data.relativeAlt as double;*/
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    } finally {
      networkControl.close();
    }
  }

}

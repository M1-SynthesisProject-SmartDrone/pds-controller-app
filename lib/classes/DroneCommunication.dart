import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:droneapp/classes/CommunicationAPI/requests/AckRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/AutopilotInfosRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/DroneInfoRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/PathInfosRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/PathLaunchRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/PathListRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RecordRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/StartDroneRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AckAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AutopilotInfosResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/OnePathAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathInfosResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathLaunchResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathListAnswer.dart';
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

  /*late bool waitingArm;
  late bool waitingRec;*/

  static final DroneCommunication _droneCommunication = DroneCommunication._internal();

  factory DroneCommunication(){
    return _droneCommunication;
  }

  DroneCommunication._internal();

  /// Send a acknowledgement message to the server and waits for the response
  /// Does not return anything, but can throw errors if connection is not well made
  Future<void> connect(String address, String port) async {
    networkControl = NetworkControl();
    networkControl.initConnection(address, int.parse(port));
    await networkControl.connect();
    try {
      Request request = AckRequest();
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      this.address = address;
      this.port = port;
      if (response.responseType != ResponseTypes.ACK) {
        return Future.error("error");
      }
      AckAnswer answer = response as AckAnswer;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }

  Future<void> launchPath(int id) async{
    try{
      Request request = PathLaunchRequest(id);

      networkControl.sendRequest(request);

      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.RESP_PATH_LAUNCH) {
        print("test");

        return Future.error("error");
      }
      PathLaunchResponse answer = response as PathLaunchResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    }catch (e, s) {
      developer.log("Error while ack", error: e);
      print("Error in armDrone" + s.toString() );
      return Future.error(e.toString());
    }
  }


  Future<AutopilotInfosResponse> getAutoPilotInfos() async {
    try{
      Request request = AutopilotInfosRequest();

      networkControl.sendRequest(request);

      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.RESP_AUTOPILOT_INFOS) {
        print("test");

        return Future.error("error");
      }
      AutopilotInfosResponse answer = response as AutopilotInfosResponse;
      return answer;
    }catch (e, s) {
      developer.log("Error while ack", error: e);
      print("Error in armDrone" + s.toString() );
      return Future.error(e.toString());
    }
  }

  Future<OnePathAnswer> getOnePath(int tripid) async{
    try{
      Request request = PathInfosRequest(tripid);

      networkControl.sendRequest(request);

      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.RESP_PATH_ONE) {
        print("test");

        return Future.error("error");
      }
      OnePathAnswer answer = response as OnePathAnswer;
      return answer;
    }catch (e, s) {
      developer.log("Error while ack", error: e);
      print("Error in armDrone" + s.toString() );
      return Future.error(e.toString());
    }
  }

  Future<void>  armDrone() async{
/*    networkControl = NetworkControl(address, int.parse(port));
    await networkControl.connect();*/
    try {
    Request request = StartDroneRequest(true);
    developer.log("Request : " + request.toJsonString());

    networkControl.sendRequest(request);
    // waitingArm = true;

      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.START_DRONE) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e, s) {
      developer.log("Error while ack", error: e);
      print("Error in armDrone" + s.toString() );
      return Future.error(e.toString());
    } /*finally {
      networkControl.close();
    }*/
  }

  Future<void> disarmDrone() async{
    try {
    Request request = StartDroneRequest(false);
    developer.log("Request : " + request.toJsonString());

    networkControl.sendRequest(request);
    // waitingArm = true;


    // if (waitingArm) {
    //   await Future.doWhile(() => Future.delayed(const Duration(milliseconds: 100)).then((_) => !waitingArm));
    // }
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));

      if (response.responseType != ResponseTypes.START_DRONE) {
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e, s) {
      developer.log("Error while ack", error: e);
      developer.log("Error in disarmDrone", error: s );

      return Future.error(e.toString());
    }
  }

  Future<void> startRecording() async{
    try {
    Request request = RecordRequest(true);
    developer.log("Request : " + request.toJsonString());

    networkControl.sendRequest(request);
    // waitingRec = true;
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      print(response.responseType );
      if (response.responseType != ResponseTypes.RESP_RECORD) {
        print("error 1" + response.responseType.toString());
        return Future.error("error");
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        print("error 2");
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e) {
      print("error 3");
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }

  Future<void> endRecording() async{
    try {
    Request request = RecordRequest(false);
    developer.log("Request : " + request.toJsonString());

    networkControl.sendRequest(request);
    // waitingRec = true;
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.RESP_RECORD) {
        return Future.error("error" + response.responseType.toString());
      }
      AnswerResponse answer = response as AnswerResponse;
      if (!answer.validated) {
        // Should never happen
        return Future.error("Server does not validate the acknowledgement");
      }
    } catch (e,s) {
      developer.log("Error while ack", error: e);
      developer.log("Error while ack", error: s.runtimeType);
      return Future.error(e.toString());
    }
  }

  Future<void> sendDroneControl(DroneControlRequest control) async{
    try {
      //developer.log("Request : " + control.toJsonString());
      networkControl.sendRequest(control);
    } catch (e) {
      developer.log("Error while ack", error: e);
      return Future.error(e.toString());
    }
  }

  Future<DroneData> getDroneData() async{
    try {
      Request request = DroneInfoRequest();
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 5));
      if (response.responseType != ResponseTypes.DRONE_DATA) {
        return Future.error("error -- ResponseType isn't the expected one");
      }
      DroneData answer = response as DroneData;
      return answer;
    } catch (e,s) {
      developer.log("Error while ack", error: e);
      developer.log("Error while ack", error: s.runtimeType);
      return Future.error(e.toString());
    }
  }

  Future<PathListAnswer> getPathList() async{
    try {
      Request request = PathListRequest();
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 5));

      if (response.responseType != ResponseTypes.RESP_PATH_GET) {
        return Future.error("error -- ResponseType isn't the expected one");
      }

      PathListAnswer answer = response as PathListAnswer;
      return answer;
    } catch (e,s) {
      developer.log("Error while ack", error: e);
      developer.log("Error while ack", error: s);
      return Future.error(e.toString());
    }
  }


  Future<PathInfosResponse> getPathInfos(int id) async{
    try {
      Request request = PathInfosRequest(id);
      developer.log("Request : " + request.toJsonString());

      networkControl.sendRequest(request);
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 5));

      if (response.responseType != ResponseTypes.RESP_PATH_ONE) {
        return Future.error("error -- ResponseType isn't the expected one");
      }

      PathInfosResponse answer = response as PathInfosResponse;
      return answer;
    } catch (e,s) {
      developer.log("Error while ack", error: e);
      developer.log("Error while ack", error: s);
      return Future.error(e.toString());
    }
  }



}

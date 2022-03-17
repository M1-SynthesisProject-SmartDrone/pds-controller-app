import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:droneapp/classes/CommunicationAPI/requests/AckRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/DroneInfoRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RecordRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/StartDroneRequest.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AckAnswer.dart';
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
      if (response.responseType != ResponseTypes.RECORD) {
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

  Future<void> endRecording() async{
    try {
    Request request = RecordRequest(false);
    developer.log("Request : " + request.toJsonString());

    networkControl.sendRequest(request);
    // waitingRec = true;
      Response response = await networkControl.receiveResponse(timeout: const Duration(seconds: 10));
      if (response.responseType != ResponseTypes.RECORD) {
        return Future.error("error");
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
      // waitingRec = true;
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


  // Future<void> updateDroneData() async {
  //   try {
  //     Response response;
  //     do {
  //       response = await networkControl.receiveResponse(
  //           timeout: const Duration(seconds: 10));
  //     if (response.responseType != ResponseTypes.DRONE_DATA) {
  //       return Future.error("error");
  //     }
  //     }while(response.responseType != ResponseTypes.DRONE_DATA);
  //     DroneData data = response as DroneData;
  //     DroneControl control = DroneControl();
  //     control.altitude = data.relativeAlt as double;
  //   } catch (e) {
  //     developer.log("Error while ack", error: e);
  //     return Future.error(e.toString());
  //   }
  // }

  /*Future<void> updateDroneData() async {
    waitingArm = false;
    waitingRec = false;
    control = DroneControl();

    Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      print("loop");
        print("works ");
        Response response = await networkControl.receiveResponse(
            timeout: const Duration(milliseconds: 50));
        print("resp " + response.responseType.toString());
        if (response.responseType == ResponseTypes.DRONE_DATA) {
          DroneData data = response as DroneData;
          control.altitude = data.relativeAlt.toDouble();
          print("altitude -> " + control.altitude.toString());
          //TODO
        }
        else if (response.responseType == ResponseTypes.START_DRONE) {
          AnswerResponse answer = response as AnswerResponse;
          if (answer.name == ResponseTypes.DRONE_STATE.value && waitingArm) {
            print("testArm");
            if (!answer.validated) {
              // Should never happen
              control.unArm();
              waitingArm = false;
              return Future.error(
                  "Server does not validate the acknowledgement");
            }
            control.arm();
            waitingArm = false;
          }
          else if (answer.name == ResponseTypes.RECORD.value && waitingRec) {
            waitingRec = false;
            if (!answer.validated) {
              // Should never happen
              return Future.error(
                  "Server does not validate the acknowledgement");
            }
            if (control.isRecording) {
              control.endRecord();
            }
            else {
              control.startRecord();
            }
          }
        }

    });
    // while(true) {
    //   print("loop");
    //   if (control.isArmed || waitingArm) {
    //     print("works ");
    //     Response response = await networkControl.receiveResponse(
    //         timeout: const Duration(seconds: 10));
    //     print("resp " + response.responseType.toString());
    //     if (response.responseType == ResponseTypes.DRONE_DATA) {
    //       DroneData data = response as DroneData;
    //       control.altitude = data.relativeAlt.toDouble();
    //       print("altitude -> " + control.altitude.toString());
    //       //TODO
    //     }
    //     else if (response.responseType == ResponseTypes.ANSWER) {
    //       AnswerResponse answer = response as AnswerResponse;
    //       if (answer.name == ResponseTypes.DRONE_STATE.value && waitingArm) {
    //         waitingArm = false;
    //
    //         print("testArm");
    //         if (!answer.validated) {
    //           // Should never happen
    //           control.unArm();
    //           return Future.error(
    //               "Server does not validate the acknowledgement");
    //         }
    //         if (control.isArmed) {
    //           control.unArm();
    //         }
    //         else {
    //           control.arm();
    //         }
    //       }
    //       else if (answer.name == ResponseTypes.RECORD.value && waitingRec) {
    //         waitingRec = false;
    //         if (!answer.validated) {
    //           // Should never happen
    //           return Future.error(
    //               "Server does not validate the acknowledgement");
    //         }
    //         if (control.isRecording) {
    //           control.endRecord();
    //         }
    //         else {
    //           control.startRecord();
    //         }
    //       }
    //     }
    //   }
    // }
  }*/

}

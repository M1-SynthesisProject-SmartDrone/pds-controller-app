
import 'dart:convert';
import 'dart:ffi';

import 'package:droneapp/classes/CommunicationAPI/responses/AckAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AutopilotInfosResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/OnePathAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathDescription.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathInfosResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathLaunchResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/PathListAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'DroneData.dart';

/// Util class used to convert a json to a Response implementation
class ResponseConverter {

  static Response convertString(String jsonString) {
    Map<String, dynamic> jsonContent = jsonDecode(jsonString);
    return ResponseConverter.convertMap(jsonContent);
  }

  static Response convertMap(Map<String, dynamic> jsonContent) {
    if (!jsonContent.containsKey("type") || !jsonContent.containsKey("content")) {
      throw ArgumentError("json content does not contain either 'type' or 'content' field");
    }
    String typeStr = jsonContent["type"];
    Map<String, dynamic> content = jsonContent["content"];
    // Find the enum value corresponding to the type string
    ResponseTypes type = ResponseTypes.values.firstWhere((element) => element.value == typeStr,
      orElse: () => throw ArgumentError("Type $typeStr unrecognized")
    );

    switch(type) {
      case ResponseTypes.START_DRONE:
         return answerFromContent(content,ResponseTypes.START_DRONE );
      case ResponseTypes.ACK:
      return ackFromContent(content);
     case ResponseTypes.DRONE_DATA:
       return droneDataFromContent(content);
      case ResponseTypes.RESP_RECORD:
        return answerFromContent(content, ResponseTypes.RESP_RECORD);
      case ResponseTypes.RESP_PATH_GET:
        return pathListFromContent(content['paths']);
      case ResponseTypes.RESP_PATH_ONE:
        print("convert resp one path");
        return pathOneFromContent(content);
      case ResponseTypes.RESP_PATH_LAUNCH:
        print("convert resp one path");
        return pathLaunchResponseFromContent(content);
      case ResponseTypes.RESP_AUTOPILOT_INFOS:
        print("convert resp one path");
        return autoPilotInfosFromContent(content);
      default:
        throw UnimplementedError("Type $typeStr does not have a converter for now");
    }
  }
}

AutopilotInfosResponse autoPilotInfosFromContent(Map<String, dynamic> content){
  return AutopilotInfosResponse.fromJson(content);
}

PathLaunchResponse pathLaunchResponseFromContent(Map<String, dynamic> content){
  return PathLaunchResponse.fromJson(content);
}

OnePathAnswer pathOneFromContent(Map<String, dynamic> content){
  print(content.entries.toString());
  return OnePathAnswer.fromJson(content);
  int id = content['id'];
  String name = content['name'];
  String date = content['date'];
  int nbPoints = content['nbPoints'];
  int nbCheckpoints = content['nbCheckpoints'];
  String lat = content['lat'];
  String lng = content['lon'];
  String alt = content['alt'];
  return OnePathAnswer(id, name, date, nbPoints, nbCheckpoints, lat, lng, alt );
}

PathListAnswer pathListFromContent(List< dynamic> content){
  // List eltList = [];
  // content.forEach((key, value) => eltList.add(PathDescription.fromJson(value)));
  List eltList = [];
  content.forEach((element) => eltList.add(PathDescription.fromJson(element)));
  return PathListAnswer(eltList.cast<PathDescription>());
}

AnswerResponse answerFromContent(Map<String, dynamic> content, ResponseTypes type) {
  String message = content["message"];
  bool validated = content["validated"];
  return AnswerResponse( validated, message, type);
}

AckAnswer ackFromContent(Map<String, dynamic> content) {
  String message = content["message"];
  bool validated = content["validated"];
  return AckAnswer( validated, message);
}

DroneData droneDataFromContent(Map<String, dynamic> content){
  int batteryRemaining = content["batteryRemaining"];
  int lat = content["lat"];
  int lon = content["lon"];
  int alt = content["alt"];
  int relativeAlt = content["relativeAlt"];
  int vx = content["vx"];
  int vy = content["vy"];
  int vz = content["vz"];
  int yawRotation = content["yawRotation"];
  return DroneData(batteryRemaining, lat.toDouble(), lon.toDouble(), alt, relativeAlt, vx, vy, vz, yawRotation);
}



import 'dart:convert';

import 'package:droneapp/classes/CommunicationAPI/responses/AckAnswer.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

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
         return answerFromContent(content);
      case ResponseTypes.ACK:
      return ackFromContent(content);
     case ResponseTypes.DRONE_DATA:
       return droneDataFromContent(content);
      case ResponseTypes.RECORD:
        return answerFromContent(content);
      default:
        throw UnimplementedError("Type $typeStr does not have a converter for now");
    }
  }
}

AnswerResponse answerFromContent(Map<String, dynamic> content) {
  String message = content["message"];
  bool validated = content["validated"];
  return AnswerResponse( validated, message);
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


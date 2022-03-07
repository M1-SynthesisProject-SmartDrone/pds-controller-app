import 'dart:convert';

import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/DroneDataResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/DroneStateResponse.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

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
        orElse: () => throw ArgumentError("Type $typeStr unrecognized"));

    switch (type) {
      case ResponseTypes.ANSWER:
        return answerFromContent(content);
      case ResponseTypes.DRONE_STATE:
        return droneStateFromContent(content);
      case ResponseTypes.DRONE_DATA:
        return droneDataFromContent(content);
      default:
        throw UnimplementedError("Type $typeStr does not have a converter for now");
    }
  }
}

AnswerResponse answerFromContent(Map<String, dynamic> content) {
  String name = content["name"];
  String message = content["message"];
  bool validated = content["validated"];
  return AnswerResponse(name, validated, message);
}

DroneDataResponse droneDataFromContent(Map<String, dynamic> content) {
  int batteryRemaining = content["batteryRemaining"];
  int lat = content["lat"];
  int lon = content["lon"];
  int alt = content["alt"];
  int relativeAlt = content["relativeAlt"];
  int vx = content["vx"];
  int vy = content["vy"];
  int vz = content["vz"];
  int yawRotation = content["yawRotation"];

  return DroneDataResponse(batteryRemaining, lat, lon, alt, relativeAlt, vx, vy, vz, yawRotation);
}

DroneStateResponse droneStateFromContent(Map<String, dynamic> content) {
  bool armed = content["armed"];
  return DroneStateResponse(armed);
}

import 'dart:convert';

import 'package:droneapp/classes/CommunicationAPI/responses/AnswerResponse.dart';
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
      orElse: () => throw ArgumentError("Type $typeStr unrecognized")
    );

    switch(type) {
      case ResponseTypes.ANSWER:
         return answerFromContent(content);
      case ResponseTypes.DRONE_STATE:
        // TODO implement this converter
      case ResponseTypes.DRONE_DATA:
        // TODO implement this converter
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


import 'dart:convert';

import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

abstract class Request{
  final RequestTypes requestType;
  Request(this.requestType);

  /// Convert the request to a json serialized string to be send
  String toJsonString() {
    return jsonEncode(toJsonObject());
  }

  /// Convert the request to a json serialized object to be send
  Map<String, dynamic> toJsonObject() {
    return {
      "type": requestType.value,
      "content": contentToJson()
    };
  }

  /// Abstract method !
  Map<String, dynamic> contentToJson();
}
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

import 'Response.dart';

class RegainControlResponse extends Response {
  bool validated;
  RegainControlResponse(this.validated) : super(ResponseTypes.RESP_REGAIN_CONTROL);

  factory RegainControlResponse.fromJson(dynamic json) {
    return RegainControlResponse(json['validated'] as bool);
  }

}
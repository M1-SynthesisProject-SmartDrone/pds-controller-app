import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';
import 'Response.dart';

class PathLaunchResponse extends Response {
  bool validated;
  PathLaunchResponse(this.validated) : super(ResponseTypes.RESP_PATH_LAUNCH);

  factory PathLaunchResponse.fromJson(dynamic json) {
    return PathLaunchResponse(json['validated'] as bool);
  }

}

import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class PathLaunchRequest extends Request{
  int tripId;
  PathLaunchRequest(this.tripId): super(RequestTypes.PATH_LAUNCH);


  @override
  Map<String, dynamic> contentToJson() {
    return {
    "pathId": tripId
    };
  }
}
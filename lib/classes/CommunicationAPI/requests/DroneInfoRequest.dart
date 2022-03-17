import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class DroneInfoRequest extends Request {
  DroneInfoRequest() : super(RequestTypes.DRONE_INFOS);

  @override
  Map<String, dynamic> contentToJson() {
    return {
    };
  }

}
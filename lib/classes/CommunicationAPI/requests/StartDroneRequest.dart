
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class StartDroneRequest extends Request {
  final bool startDrone;

  StartDroneRequest(this.startDrone) : super(RequestTypes.START_DRONE);

  @override
  Map<String, dynamic> contentToJson() {
    return {
      "startDrone": startDrone
    };
  }

}
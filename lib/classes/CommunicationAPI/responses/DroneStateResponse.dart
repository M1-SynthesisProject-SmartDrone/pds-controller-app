import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class DroneStateResponse extends Response {
  final bool isArmed;

  DroneStateResponse(this.isArmed) : super(ResponseTypes.DRONE_DATA);
}

import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class DroneDataResponse extends Response {
  final int batteryRemaining;
  final int lat;
  final int lon;
  final int alt;
  final int relativeAlt;
  final int vx;
  final int vy;
  final int vz;
  final int yawRotation;

  DroneDataResponse(this.batteryRemaining, this.lat, this.lon, this.alt, this.relativeAlt, this.vx, this.vy, this.vz,
      this.yawRotation)
      : super(ResponseTypes.DRONE_DATA);
}

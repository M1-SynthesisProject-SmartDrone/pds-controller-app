import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class DroneData extends Response{

  late int batteryRemaining;
  late double lat;
  late double lon;
  late int alt;
  late int relativeAlt;
  late int vx;
  late int vy;
  late int vz;
  late int yawRotation;


  DroneData(this.batteryRemaining, this.lat, this.lon, this.alt,
      this.relativeAlt, this.vx, this.vy, this.vz, this.yawRotation) : super(ResponseTypes.DRONE_DATA);

  @override
  Map<String, dynamic> contentToJson() {
    return {
      "batteryRemaining": batteryRemaining,
      "lat": lat,
      "lon": lon,
      "alt": alt,
      "relativeAlt": relativeAlt,
      "vx": vx,
      "vy": vy,
      "vz": vz,
      "yawRotation": yawRotation
    };
  }

}
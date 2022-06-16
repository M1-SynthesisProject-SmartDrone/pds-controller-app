import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

import 'Response.dart';

class AutopilotInfosResponse extends Response {
  late bool armed;
  late bool recording;
  late int batteryRemaining;
  late int lat;
  late int lon;
  late int alt;
  late int relativeAlt;
  late int vx;
  late int vy;
  late int vz;
  late int yawRotation;
  late bool running;
  late bool errorMode;
  late bool manualControl;

  AutopilotInfosResponse(this.armed, this.recording, this.batteryRemaining, this.lat,this.lon, this.alt, this.relativeAlt, this.vx, this.vy, this.vz, this.yawRotation, this.running, this.errorMode, this.manualControl) : super(ResponseTypes.RESP_AUTOPILOT_INFOS);

  factory AutopilotInfosResponse.fromJson(dynamic json) {
    return AutopilotInfosResponse(
        json['armed'] as bool,
        json['recording'] as bool,
        json['batteryRemaining'] as int,
        json['lat'] as int,
        json['lon'] as int,
        json['alt'] as int,
        json['relativeAlt'] as int,
        json['vx'] as int,
        json['vy'] as int,
        json['vz'] as int,
        json['yawRotation'] as int,
        json['running'] as bool,
        json['errorMode'] as bool,
        json['manualControl'] as bool

    );
  }
}
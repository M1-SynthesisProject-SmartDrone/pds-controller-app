import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class DroneControlRequest extends Request {
  final double x;
  final double y;
  final double z;
  final double r;


  DroneControlRequest(this.x, this.y, this.z, this.r) : super(RequestTypes.MANUAL_CONTROL);

  @override
  Map<String, dynamic> contentToJson() {
    return {
      "x": x ,
      "y": y ,
      "z": z ,
      "r": r
    };
  }

}
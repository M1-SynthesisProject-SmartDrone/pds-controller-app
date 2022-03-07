
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class ManualControlRequest extends Request {
  final double x, y, z, r;

  ManualControlRequest(this.x, this.y, this.z, this.r) : super(RequestTypes.MANUAL_CONTROL);

  @override
  Map<String, dynamic> contentToJson() {
    // No real content for this request
    return {
      "x": x,
      "y": y,
      "z": z,
      "r": r,
    };
  }
}
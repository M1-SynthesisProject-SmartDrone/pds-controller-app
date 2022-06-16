import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

import 'Request.dart';

class AutopilotInfosRequest extends Request {

  AutopilotInfosRequest() : super(RequestTypes.AUTOPILOT_INFOS);

  @override
  Map<String, dynamic> contentToJson() {
    // No real content for this request
    return {};
  }


}
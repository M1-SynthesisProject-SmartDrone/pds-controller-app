import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

import 'Request.dart';

class ResumeAutopilotRequest extends Request{
  ResumeAutopilotRequest() : super(RequestTypes.RESUME_AUTOPILOT);

  @override
  Map<String, dynamic> contentToJson() {
    return{};
  }
}
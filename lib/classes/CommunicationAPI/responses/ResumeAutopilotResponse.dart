import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class ResumeAutopilotResponse extends Response{
  bool validated;
  ResumeAutopilotResponse(this.validated) : super(ResponseTypes.RESP_RESUME_AUTOPILOT);

  factory ResumeAutopilotResponse.fromJson(dynamic json) {
    return ResumeAutopilotResponse(json['validated'] as bool);
  }
}
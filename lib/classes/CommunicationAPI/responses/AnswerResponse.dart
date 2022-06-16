
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class AnswerResponse extends Response {
  final bool validated;
  final String message;

  AnswerResponse(this.validated, this.message, ResponseTypes type) : super(type);
}



import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class AnswerResponse extends Response {
  final bool validated;
  final String name;
  final String message;

  AnswerResponse(this.name, this.validated, this.message) : super(ResponseTypes.ANSWER);
}
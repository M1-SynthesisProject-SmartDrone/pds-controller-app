import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class AckAnswer extends Response {
  final bool validated;
  final String message;

  AckAnswer(this.validated, this.message) : super(ResponseTypes.ACK);
}
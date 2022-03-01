
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

abstract class Response {
  final ResponseTypes responseType;
  Response(this.responseType);
}
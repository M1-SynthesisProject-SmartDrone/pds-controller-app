
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class AckRequest extends Request {
  AckRequest() : super(RequestTypes.ACK);

  @override
  Map<String, dynamic> contentToJson() {
    // No real content for this request
    return {};
  }
}
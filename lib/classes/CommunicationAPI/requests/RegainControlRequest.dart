import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class RegainControlRequest extends Request{
  RegainControlRequest(): super(RequestTypes.REGAIN_CONTROL);

  @override
  Map<String, dynamic> contentToJson() {
    return{};
  }
}
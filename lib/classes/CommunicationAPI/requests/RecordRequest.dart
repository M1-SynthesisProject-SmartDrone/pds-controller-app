
import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';

class RecordRequest extends Request {
  final bool record;

  RecordRequest(this.record) : super(RequestTypes.RECORD);

  @override
  Map<String, dynamic> contentToJson() {
    return {
      "record": record
    };
  }

}
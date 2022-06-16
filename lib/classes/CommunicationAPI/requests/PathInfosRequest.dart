import 'package:droneapp/classes/CommunicationAPI/requests/Request.dart';
import 'package:droneapp/classes/CommunicationAPI/requests/RequestTypes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PathInfosRequest extends Request{

  late int id;

  PathInfosRequest(this.id) : super(RequestTypes.PATH_ONE);

  @override
  Map<String, dynamic> contentToJson() {
    return {
      "id": id,
    };

  }

}
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ResponseTypes.dart';

class PathInfosResponse extends Response{

  late int id;
  late String name;
  late String date;
  late List<LatLng> positions;

  PathInfosResponse(this.id, this.name, this.date,this.positions) : super(ResponseTypes.RESP_PATH_ONE);

  @override
  Map<String, dynamic> contentToJson() {
    return {
      "id": id,
      "name": name,
      "date": date,
      "positions": positions,

    };

  }

}
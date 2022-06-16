import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class OnePathAnswer extends Response {
  late int id;
  late String name;
  late String date;
  late int nbPoints;
  late int nbCheckpoints;
  late String lat;
  late String long;
  late String alt;

  OnePathAnswer(this.id, this.name, this.date, this.nbPoints, this.nbCheckpoints, this.lat, this.long, this.alt) : super(ResponseTypes.RESP_PATH_ONE);
  factory OnePathAnswer.fromJson(dynamic json) {
    return OnePathAnswer(json['id'] as int, json['name'] as String, json['date'] as String, json['nbPoints'] as int, json['nbCheckpoints'] as int, json['departure']['lat'] as String, json['departure']['lon'] as String, json['departure']['alt'] as String );
  }
}
import 'package:droneapp/classes/CommunicationAPI/responses/PathDescription.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseTypes.dart';

class PathListAnswer extends Response{

  late List<PathDescription> pathList;
  PathListAnswer(this.pathList) : super(ResponseTypes.RESP_PATH_GET);



}
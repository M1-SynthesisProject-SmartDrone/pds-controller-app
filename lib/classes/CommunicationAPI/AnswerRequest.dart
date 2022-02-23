import 'package:droneapp/classes/CommunicationAPI/RequestTypes.dart';
import 'package:gson/gson.dart';

import 'Request.dart';

class AnswerRequest{

  late String name;
  late bool validated;
  late String message;


  AnswerRequest(Request request){
    if(request.getType() == RequestType.ANSWER){
      Gson gson = Gson();
      GsonDecoder decoder = gson.decoder;
      Map<String, dynamic> requestval = decoder.decode(request.getContent());

      validated = requestval["validated"];
      name = requestval["name"];
      message = requestval["message"];

    }
  }



}
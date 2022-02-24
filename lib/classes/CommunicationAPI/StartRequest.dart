import 'package:droneapp/classes/CommunicationAPI/RequestTypes.dart';
import 'package:gson/gson.dart';

import 'Request.dart';

class StartRequest{

  bool startDrone = false;


  StartRequest(bool startDrone){
    this.startDrone = startDrone;
  }

  StartRequest_request(Request request){
    if(request.getType() == RequestType.STARTDRONE){
      Gson gson = Gson();
      GsonDecoder decoder = gson.decoder;
      Map<String, dynamic> requestval = decoder.decode(request.getContent());

      if(requestval.containsKey("startDrone")){
        startDrone = requestval["startDrone"];
      }
    }
  }

  bool isStarted(){
    return startDrone;
  }

  setStartDrone(bool armDrone){
    this.startDrone = startDrone;
  }

  Map toJson() =>{
    'startDrone' : startDrone,
  };

}
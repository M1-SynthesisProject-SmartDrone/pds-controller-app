import 'package:droneapp/classes/CommunicationAPI/Request.dart';
import 'package:gson/gson.dart';

class RequestImpl extends Request{

  late String type;
  late Object content;

  RequestImpl(String type, Object content){
    this.type = type;
    this.content = content;
  }

  RequestImpl_void(){

  }

  @override
  Object getContent() {
    return content;
  }

  @override
  String getRequest() {
    String request = "{ \"type\" : \"" + type +"\" , \"content\" :";
    Gson gson = Gson();
    GsonEncoder encoder = gson.encoder;

    request+=encoder.encode(request);
    request+="};";

    return request;

  }

  @override
  String getType() {
    return type;
  }

  
}
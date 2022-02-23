import 'package:gson/gson.dart';

import 'CommunicationAPI/Request.dart';

class ProjectUtils{
  static Request receiveRequest(String jsonString) {
    Gson gson = Gson();
    GsonDecoder decoder = gson.decoder;
    Request request = decoder.decode(jsonString);
    return request;
  }
}
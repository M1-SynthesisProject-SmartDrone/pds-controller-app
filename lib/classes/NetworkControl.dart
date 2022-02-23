import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:droneapp/classes/CommunicationAPI/RequestImpl.dart';
import 'package:droneapp/classes/ProjectUtils.dart';
import 'package:udp/udp.dart';

import 'CommunicationAPI/Request.dart';

class NetworkControl{

  late InternetAddress address;
  late int port;
  late RawDatagramSocket socket;

  NetworkControl(InternetAddress address, int port){
    this.address =address;
    this.port = port;
    print(address.toString() + " " + port.toString());

  }

  Future<bool> connect({int duration = 500}) async {
    await RawDatagramSocket.bind( address, port).then((value) {
      socket = value;
      Duration dur = Duration(milliseconds: duration);
      socket.timeout(dur);

    }).catchError((onError) => print("Error : " + onError.toString()));

    return socket.isEmpty;
  }

  void sendData(Request request) async {
    var codec = new Utf8Codec();
    List<int> data = codec.encode(request.getRequest());
    await socket.send(data, address, port);
  }

  Request? getData(){
    socket.listen((event) {
          (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        Request req = ProjectUtils.receiveRequest(data.toString());
        return req;
      };

      // handle errors
      onError: (error) {
        return null;
      };

      // handle server ending connection
      onDone: () {
        return null;
      };
    });
    }


}
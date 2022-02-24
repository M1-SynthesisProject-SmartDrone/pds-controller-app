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

  Future<void> connect({int duration = 500}) async {
    socket = await RawDatagramSocket.bind( InternetAddress.anyIPv4, port);
    socket.timeout(Duration(milliseconds: duration));
  }

  void sendData(Request request) async {
    var codec = new Utf8Codec();
    List<int> data = codec.encode(request.getRequest());
    socket.send(data, address, port);
  }

  Request getData()  {
      Datagram? data = socket.receive();
      Request request = ProjectUtils.receiveRequest(jsonDecode(data.toString()));
      return request;

    }


}
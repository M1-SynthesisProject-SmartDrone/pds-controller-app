import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:developer' as developer;

import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseConverter.dart';
import 'package:droneapp/classes/ProjectUtils.dart';
import 'package:udp/udp.dart';

import 'CommunicationAPI/requests/Request.dart';

class NetworkControl {
  late InternetAddress address;
  late Port port;
  late UDP udpSocket;
  late RawDatagramSocket socket;

  final Queue<Response> responseQueue = Queue();

  NetworkControl(String ipAddress, int port) {
    address = InternetAddress(ipAddress, type: InternetAddressType.any);
    this.port = Port(port);
    developer.log(address.toString() + " " + port.toString(), name: "network.control");
  }

  Future<void> connect({int duration = 500}) async {
    udpSocket = await UDP.bind(Endpoint.any(port: port));
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port.value);
  }

  void sendRequest(Request request) {
    const codec = Utf8Codec();
    List<int> data = codec.encode(request.toJsonString());
    socket.send(data, address, port.value);
    // int responseCode = await udpSocket.send(data, Endpoint.unicast(address, port: port));
    // if (responseCode == -1) {
    //   throw const SocketException("Udp socket already closed");
    // }
  }

  Future<Response> receiveResponse() async {
    // udpSocket.asStream()
    Datagram? data = socket.receive();
    if (data == null) {
      return Future.error("Error while receiving the data");
    }
    Response response = ResponseConverter.convertString(data.toString());
    return Future.value(response);
  }

  // Future<Response> sendRequestWaitResponse(Request request) async {
  //   sendRequest(request);
  //   var wait = RawDatagramSocket.bind(InternetAddress.anyIPv4, port.value)
  //     .then((datagramSocket) {
  //       datagramSocket.listen((event) {
  //         switch(event) {
  //           case RawSocketEvent.read:
  //             Datagram datagram = datagramSocket.receive();
  //         }
  //       });
  //     }
  //     );
  // }
}

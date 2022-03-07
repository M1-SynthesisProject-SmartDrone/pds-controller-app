import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseConverter.dart';
import 'package:droneapp/classes/Network/UdpSocket.dart';

import '../CommunicationAPI/requests/Request.dart';

/// This class is a high-level abstraction of the [UdpSocket] class
class NetworkControl {
  late InternetAddress address;
  late int port = -1;
  late UdpSocket udpSocket;

  Future<void> bind(String ipAddress, int port) async {
    address = InternetAddress(ipAddress, type: InternetAddressType.any);
    if (port != this.port) {
      this.port = port;
      udpSocket = await UdpSocket.bind(port);
    }
  }

  Future<int> sendRequest(Request request) async {
    const codec = Utf8Codec();
    List<int> data = codec.encode(request.toJsonString());
    return await udpSocket.send(data, address, port);
  }

  Future<Response> receiveResponse({Duration? timeout}) async {
    Datagram datagram = await udpSocket.receive(timeout: timeout);
    Response response = ResponseConverter.convertString(String.fromCharCodes(datagram.data));
    return Future.value(response);
  }

  Future<void> close() async {
    await udpSocket.closeSocket();
  }
}

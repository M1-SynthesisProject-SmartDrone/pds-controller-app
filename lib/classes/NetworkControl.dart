import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:droneapp/classes/CommunicationAPI/responses/Response.dart';
import 'package:droneapp/classes/CommunicationAPI/responses/ResponseConverter.dart';
import 'package:droneapp/classes/Network/UdpSocket.dart';

import 'CommunicationAPI/requests/Request.dart';
import 'CommunicationAPI/responses/ResponseTypes.dart';
import 'DroneCommunication.dart';
import 'DroneControl.dart';

class NetworkControl {
  late InternetAddress address;
  late int port;
  late UdpSocket udpSocket;
  late DroneControl control;
  late DroneCommunication communication;

  static final NetworkControl _networkControl = NetworkControl._internal();

  factory NetworkControl(){
    return _networkControl;
  }

  NetworkControl._internal();

  Future<void> updateDroneData() async {
    control = DroneControl();
    communication = DroneCommunication();
  }

  void initConnection(String ipAddress, int port) {
    address = InternetAddress(ipAddress, type: InternetAddressType.any);
    this.port = port;
    developer.log(address.toString() + " " + port.toString(), name: "network.control");
  }


  Future<void> connect() async {
    udpSocket = await UdpSocket.bind(port);
  }

  Future<int> sendRequest(Request request) async {
    const codec = Utf8Codec();
    List<int> data = codec.encode(request.toJsonString());
    return await udpSocket.send(data, address, port);
  }

  Future<Response> receiveResponse({Duration? timeout}) async {

    Datagram datagram = await udpSocket.receive(timeout: timeout);
    Response response = ResponseConverter.convertString(
        String.fromCharCodes(datagram.data));
    return Future.value(response);
  }

  Future<void> close() async {
    await udpSocket.closeSocket();
  }
}

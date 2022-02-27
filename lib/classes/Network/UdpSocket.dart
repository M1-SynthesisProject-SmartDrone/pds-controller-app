import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:async/async.dart';

/// A wrapper class to handle RawDatagramSocket more easily
class UdpSocket {
  final RawDatagramSocket datagramSocket;

  /// A view on events passing by RawDatagramSocket
  final StreamQueue _streamQueue;

  UdpSocket(this.datagramSocket) : _streamQueue = StreamQueue(datagramSocket) {}

  /// Bind a socket on a specific port
  ///
  /// If "host" is not defined, InternetAddress.anyIPv4 will be used
  static Future<UdpSocket> bind(int port, {dynamic host, bool reuseAddress = false, bool reusePort = false}) async {
    dynamic hostUsed = host ?? InternetAddress.anyIPv4;
    var socket = await RawDatagramSocket.bind(hostUsed, port, reusePort: reusePort, reuseAddress: reuseAddress);

    return UdpSocket(socket);
  }

  /// Send data from a specific port.
  ///
  /// [address] Can be either an instance of InternetAddress or a String representing an IP address (IPv4 or IPv6)
  Future<int> send(List<int> data, dynamic address, int port) async {
    // Check if we have a InternetAddress of a string representing the ip address
    InternetAddress internetAddress;
    if (address is InternetAddress) {
      internetAddress = address;
    } else if (address is String) {
      internetAddress = InternetAddress(address, type: InternetAddressType.any);
    } else {
      throw ArgumentError("address must be an InternetAddress instance or a string representing an IP address");
    }
    return datagramSocket.send(data, internetAddress, port);
  }

  /// Receive a datagram from the rawDatagramSocket
  ///
  /// If the timeout is set, the Future will throw an error if no message is received in the allotted time.
  Future<Datagram> receive({Duration? timeout}) {
    // This Completer permits to use future in callbacks used by RawDatagramSocket
    // (This is the resolve/reject of dart in a nutshell)
    // Completer.sync permits to end the Future on the first completer.complete call (or error)
    final Completer completer = Completer<Datagram>.sync();

    if (timeout != null) {
      // If completer is not still called after the end of the timeout, an error will be thrown
      // Else, it will not to anything
      Future.delayed(timeout).then((_) {
        if (!completer.isCompleted) {
          completer.completeError("Timeout exceeded");
        }
      });
    }

    // Launch the receive task for real
    // We use a micro task because it has priority on the event queue
    // over the callback tasks (The Future.delayed just before for example)
    Future.microtask(() async {
      try {
        while (true) {
          RawSocketEvent event = await _streamQueue.peek;
          switch (event) {
            case RawSocketEvent.read:
              if (completer.isCompleted) {
                return; // Could happen if we have an error or the timeout exceeded just before
              } else {
                // We actually received the message, yeah !
                var datagram = datagramSocket.receive();
                if (datagram == null) {
                  completer.completeError("Received null datagram");
                }
                completer.complete(datagram);
              }
              break;
            case RawSocketEvent.closed:
              // This should not happen, but it is always good to plan ahead
              if (completer.isCompleted) {
                return;
              } else {
                completer.completeError("Socket closed during waiting for receive");
              }
              break;
            default:
              // We don't care about the current event. Wait for the next event to come
              await _streamQueue.next;
          }
        }
      } catch (e) {
        developer.log("Error while receiving message : $e", name: "udp.socket");
      }
    });
    return completer.future as Future<Datagram>;
  }

  /// Close the socket and waits until this socket is closed
  Future<void> closeSocket() async {
    try {
      datagramSocket.close();
      // Wait until we have the close event and "destroy" the streamQueue
      while (await _streamQueue.peek != RawSocketEvent.closed) {
        await _streamQueue.next;
      }
      await _streamQueue.cancel();
    } catch (e) {
      throw SocketException("Error while closing socket : $e");
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket(String token) {
    socket = IO.io('http://localhost:8081', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('newNotification', (data) {
      print('New notification received: ${jsonEncode(data)}');
    });

    socket.onError((error) {
      print('Error: $error');
    });

    socket.onDisconnect((_) => print('Disconnected from the server'));
  }

  void connect(String userId) {
    socket.connect();
    socket.emit('join', userId);
  }

  void disconnect() {
    socket.disconnect();
  }
}

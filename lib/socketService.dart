import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model/notification.dart';

class SocketService {
  late IO.Socket socket;

  void initSocket(String token) {
    socket = IO.io('http://10.0.2.2:8081', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'token': token},
    });

    socket.on('newNotification', (data) {});

    socket.onError((error) {});
  }

  void connect(String userId) {
    socket.connect();
    socket.emit('join', userId);
  }

  void disconnect() {
    socket.disconnect();
  }

  void listenForNotifications({
    required Function(NotificationModel) onNewNotification,
    required VoidCallback updateCount,
  }) {
    socket.on('newNotification', (data) {
      final notification = NotificationModel.fromJson(data);
      onNewNotification(notification);
      updateCount();
    });
  }
}

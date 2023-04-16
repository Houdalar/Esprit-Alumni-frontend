import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/notification.dart';
import '../../../viewmodel/profileViewModel.dart';
import '../../components/constum_componenets/notificationItem.dart';

class Notifications extends StatefulWidget {
  final String token;
  final VoidCallback updateCount;
  const Notifications(
      {required this.token, required this.updateCount, Key? key})
      : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<NotificationModel>>(
        future: ProfileViewModel.getNotification(widget.token, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItem(
                  notification: notification,
                  token: widget.token,
                  onRead: _onNotificationRead,
                  updateCount: widget.updateCount,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch notifications!'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _onNotificationRead(NotificationModel updatedNotification) {
    setState(() {
      final index = notifications.indexWhere(
          (notification) => notification.id == updatedNotification.id);
      if (index != -1) {
        notifications[index] = updatedNotification;
      }
    });
  }
}

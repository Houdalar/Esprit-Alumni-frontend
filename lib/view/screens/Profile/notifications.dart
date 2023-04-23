import 'package:flutter/material.dart';
import '../../../model/notification.dart';
import '../../../viewmodel/profileViewModel.dart';
import '../../components/constum_componenets/notificationItem.dart';

class Notifications extends StatefulWidget {
  final String token;
  final VoidCallback updateCount;
  final Function(NotificationModel) onNewNotification;

  const Notifications({
    required this.token,
    required this.updateCount,
    required this.onNewNotification,
    Key? key,
  }) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
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
            return const Center(
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

  void newNotification(NotificationModel notification) {
    setState(() {
      notifications.insert(0, notification);
    });
    widget.onNewNotification(notification);
    widget.updateCount();
  }

  void _onNotificationRead(NotificationModel updatedNotification) {
    setState(() {
      final index = notifications.indexWhere(
          (notification) => notification.id == updatedNotification.id);
      if (index != -1) {
        notifications[index] = updatedNotification;
      }
    });
    widget.updateCount();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

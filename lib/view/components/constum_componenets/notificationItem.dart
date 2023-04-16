import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/notification.dart';
import '../../../viewmodel/profileViewModel.dart';

class NotificationItem extends StatefulWidget {
  NotificationModel notification;
  final Function(NotificationModel) onRead;
  final String token;
  final VoidCallback updateCount;

  NotificationItem(
      {required this.notification,
      required this.onRead,
      required this.token,
      required this.updateCount});

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  NotificationModel? _notification;

  @override
  void initState() {
    super.initState();

    _notification = widget.notification;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!_notification!.isRead) {
          bool success = await ProfileViewModel.markNotificationAsRead(
              widget.token, _notification!.id);
          if (success) {
            setState(() {
              _notification =
                  NotificationModel.copyWith(_notification!, isRead: true);
            });
            widget.onRead(_notification!);
            widget.updateCount();
          }
        }
        // Navigate to appropriate screen based on notification type
      },
      child: Container(
        color: widget.notification.isRead ? Colors.white : Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      widget.notification.senderId['profile_image']),
                ),
                if (widget.notification.notificationType == 'like' ||
                    widget.notification.notificationType == 'like comment' ||
                    widget.notification.notificationType == 'share' ||
                    widget.notification.notificationType == 'comment')
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryDark,
                      ),
                      child: Icon(
                        widget.notification.notificationType == 'like' ||
                                widget.notification.notificationType ==
                                    'like comment'
                            ? Icons.favorite
                            : widget.notification.notificationType == 'comment'
                                ? Icons.mode_comment
                                : Icons.share,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: widget.notification.senderId['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: _getMessageText(widget.notification),
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.notification.elapsedTimeString,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            if (!widget.notification.isRead)
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryDark,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getMessageText(NotificationModel notification) {
    switch (notification.notificationType) {
      case 'like':
        return ' liked your post.';
      case 'like comment':
        return ' liked your comment.';
      case 'follow':
        return ' started following you.';
      case 'share':
        return ' shared your post.';
      case 'comment':
        return ' commented on your post.';
      default:
        return '';
    }
  }
}

import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import '../../../model/notification.dart';
import '../../../viewmodel/profileViewModel.dart';
import '../../screens/Profile/profile.dart';
import '../../screens/Profile/singlePostView.dart';

class NotificationItem extends StatefulWidget {
  NotificationModel notification;
  final Function(NotificationModel) onRead;
  final String token;
  final VoidCallback updateCount;

  NotificationItem(
      {required this.notification,
      required this.onRead,
      required this.token,
      required this.updateCount,
      Key? key})
      : super(key: key);

  @override
  NotificationItemState createState() => NotificationItemState();
}

class NotificationItemState extends State<NotificationItem> {
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
        switch (_notification!.notificationType) {
          case 'like':
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SinglePostView(
                    postId: _notification!.postId!,
                  ),
                ),
              );
              break;
            }
          case 'like comment':

          case 'follow':
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    user: _notification!.senderId['_id'],
                    isCurrentUser: false,
                  ),
                ),
              );
              break;
            }

          case 'share':

          case 'comment':

          default:
        }
      },
      child: Container(
        color: widget.notification.isRead ? Colors.white : Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      decoration: const BoxDecoration(
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
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: widget.notification.senderId['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: _getMessageText(widget.notification),
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.notification.elapsedTimeString,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            if (!widget.notification.isRead)
              Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
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

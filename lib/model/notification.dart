import 'package:timeago/timeago.dart' as timeago;

class NotificationModel {
  final String id;
  final Map<String, dynamic> senderId;
  final String receiverId;
  final String? postId;
  final String? commentId;
  final String notificationType;
  final String date;
  final String elapsedTimeString;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.postId = "",
    this.commentId = "",
    required this.notificationType,
    required this.date,
    required this.elapsedTimeString,
    required this.isRead,
  });

  NotificationModel.copyWith(NotificationModel oldNotification,
      {required bool isRead})
      : id = oldNotification.id,
        senderId = oldNotification.senderId,
        receiverId = oldNotification.receiverId,
        date = oldNotification.date,
        elapsedTimeString = oldNotification.elapsedTimeString,
        postId = oldNotification.postId,
        commentId = oldNotification.commentId,
        notificationType = oldNotification.notificationType,
        isRead = isRead;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json['date']);
    // Duration difference = DateTime.now().difference(date);
    String elapsedTimeString = timeago.format(date);
    return NotificationModel(
      id: json['_id'] ?? '',
      senderId: {
        "_id": json['senderId']['_id'],
        "username": json['senderId']['username'],
        "profile_image": json['senderId']['profile']['profile_image'],
      },
      receiverId: json['receiverId'],
      postId: json['postId'] ?? '',
      commentId: json['commentId'] ?? '',
      notificationType: json['notificationType'],
      date: json['date'],
      elapsedTimeString: elapsedTimeString,
      isRead: json['isRead'],
    );
  }
}

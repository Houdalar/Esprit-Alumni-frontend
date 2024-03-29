import 'package:timeago/timeago.dart' as timeago;

class CommentModel {
  final Map<String, dynamic> owner;
  final String post;
  final String content;
  final List<String> likes;
  final DateTime createdAt;
  final int numberOfLikes;
  final String elapsedTimeString;
  final String id;

  CommentModel({
    required this.owner,
    required this.post,
    required this.content,
    required this.likes,
    required this.createdAt,
    required this.numberOfLikes,
    required this.elapsedTimeString,
    required this.id,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    DateTime createdAt = DateTime.parse(json['createdAt']);
    //Duration difference = DateTime.now().difference(createdAt);
    String elapsedTimeString = timeago.format(createdAt);

    return CommentModel(
      owner: {
        "_id": json['owner']['_id'],
        "username": json['owner']['username'],
        "profile_image": json['owner']['profile']['profile_image']
      },
      post: json['post'],
      content: json['content'],
      likes: List<String>.from(json['likes']),
      createdAt: createdAt,
      numberOfLikes: json['numberOfLikes'],
      elapsedTimeString: elapsedTimeString,
      id: json['_id'],
    );
  }
}

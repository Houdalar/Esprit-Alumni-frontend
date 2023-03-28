import 'package:timeago/timeago.dart' as timeago;

class PostModel {
  final Map<String, dynamic> owner;
  final String caption;
  final String image;
  final List<String> likes;
  final List<String> comments;
  final DateTime createdAt;
  final int numberOfLikes;
  final int numberOfComments;
  final String category;
  final int numberOfShares;
  final String
      elapsedTimeString; // New property to store the elapsed time as a string

  PostModel({
    required this.owner,
    required this.caption,
    required this.image,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.category,
    required this.numberOfShares,
    required this.elapsedTimeString,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    DateTime createdAt = DateTime.parse(json['createdAt']);
    Duration difference = DateTime.now().difference(createdAt);
    String elapsedTimeString = timeago.format(createdAt);

    return PostModel(
      owner: {
        "_id": json['owner']['_id'],
        "username": json['owner']['username'],
        "profile_image": json['owner']['profile']['profile_image']
      },
      caption: json['caption'],
      image: json['image'],
      likes: List<String>.from(json['likes']),
      comments: List<String>.from(json['comments']),
      createdAt: createdAt,
      numberOfLikes: json['numberOfLikes'],
      numberOfComments: json['numberOfComments'],
      category: json['category'],
      numberOfShares: json['numberOfShares'],
      elapsedTimeString:
          elapsedTimeString, // Store the elapsed time as a string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'caption': caption,
      'image': image,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'numberOfLikes': numberOfLikes,
      'numberOfComments': numberOfComments,
      'category': category,
      'numberOfShares': numberOfShares,
    };
  }
}

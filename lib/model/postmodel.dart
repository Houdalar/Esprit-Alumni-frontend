import 'package:timeago/timeago.dart' as timeago;

class PostModel {
  final String id;
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
  final String elapsedTimeString;
  final Map<String, dynamic>? sharedFrom;

  PostModel({
    required this.id,
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
    this.sharedFrom,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    DateTime createdAt = DateTime.parse(json['createdAt']);
    //Duration difference = DateTime.now().difference(createdAt);
    String elapsedTimeString = timeago.format(createdAt);

    Map<String, dynamic>? sharedFromJson;
    if (json['sharedFrom'] != null) {
      sharedFromJson = {
        "_id": json['sharedFrom']['_id'],
        "username": json['sharedFrom']['owner']['username'],
        "profile_image": json['sharedFrom']['owner']['profile']
            ['profile_image'],
        "postDescription": json['sharedFrom']['caption'],
        "postPhotoUrl": json['sharedFrom']['image'],
        "numLikes": json['sharedFrom']['numberOfLikes'],
        "numComments": json['sharedFrom']['numberOfComments'],
        "createdAt": json['sharedFrom']['createdAt'],
      };
    }

    return PostModel(
      id: json['_id'],
      owner: {
        "_id": json['owner']['_id'],
        "username": json['owner']['username'],
        "profile_image": json['owner']['profile']['profile_image'],
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
      elapsedTimeString: elapsedTimeString,
      sharedFrom: sharedFromJson,
    );
  }
}

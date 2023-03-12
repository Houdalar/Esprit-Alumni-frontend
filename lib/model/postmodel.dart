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
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
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
      createdAt: DateTime.parse(json['createdAt']),
      numberOfLikes: json['numberOfLikes'],
      numberOfComments: json['numberOfComments'],
      category: json['category'],
      numberOfShares: json['numberOfShares'],
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

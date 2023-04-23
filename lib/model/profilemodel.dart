class ProfileModel {
  final String id;
  final Map<String, dynamic> owner;
  final String location;
  final String summary;
  final String? education;
  final String status;
  final List<String> experience;
  final List<String> skills;
  late final String profileImage;
  final List<String> following;
  final List<String> followers;
  final int numberOfFollowers;
  final int numberOfFollowing;
  final List<String> posts;

  ProfileModel({
    required this.id,
    required this.owner,
    required this.location,
    required this.summary,
    required this.education,
    required this.status,
    required this.experience,
    required this.skills,
    required this.profileImage,
    required this.following,
    required this.followers,
    required this.numberOfFollowers,
    required this.numberOfFollowing,
    required this.posts,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      owner: {
        "_id": json['owner']['_id'],
        "username": json['owner']['username'],
      },
      location: json['location'],
      summary: json['summary'],
      education: json['education'] ?? '',
      status: json['status'],
      experience: List<String>.from(json['experience'].map((x) => x)),
      skills: List<String>.from(json['skills'].map((x) => x)),
      profileImage: json['profile_image'],
      following: List<String>.from(json['following'].map((x) => x)),
      followers: List<String>.from(json['followers'].map((x) => x)),
      numberOfFollowers: json['number_of_followers'],
      numberOfFollowing: json['number_of_following'],
      posts: List<String>.from(json['posts'].map((x) => x)),
    );
  }
}

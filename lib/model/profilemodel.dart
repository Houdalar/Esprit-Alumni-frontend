class ProfileModel {
  final String id;
  final String ownerId;
  final String location;
  final String summary;
  final List<String> education;
  final String experience;
  final String status;
  final List<String> skills;
  final String profileImage;
  final List<String> following;
  final List<String> followers;
  final int numberOfFollowers;
  final int numberOfFollowing;
  final List<String> posts;

  ProfileModel({
    required this.id,
    required this.ownerId,
    required this.location,
    required this.summary,
    required this.education,
    required this.experience,
    required this.status,
    required this.skills,
    required this.profileImage,
    required this.following,
    required this.followers,
    required this.numberOfFollowers,
    required this.numberOfFollowing,
    required this.posts,
  });

  /*factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      ownerId: json['owner']['_id'],
      location: json['location'],
      summary: json['summary'],
      education: List<String>.from(json['education']),
      experience: json['experience'],
      status: json['status'],
      skills: List<String>.from(json['skills']),
      profileImage: json['profile_image'],
      following: List<String>.from(json['following']),
      followers: List<String>.from(json['followers']),
      numberOfFollowers: json['number_of_followers'],
      numberOfFollowing: json['number_of_following'],
      posts: List<String>.from(json['posts']),
    );
  }*/

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      ownerId: json['owner']['_id'] ?? '',
      location: json['location'] ?? '',
      summary: json['summary'] ?? '',
      education: List<String>.from(json['education'] ?? []),
      experience: json['experience'] ?? '',
      status: json['status'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      profileImage: json['profile_image'] ?? '',
      following: List<String>.from(json['following'] ?? []),
      followers: List<String>.from(json['followers'] ?? []),
      numberOfFollowers: json['number_of_followers'] ?? 0,
      numberOfFollowing: json['number_of_following'] ?? 0,
      posts: List<String>.from(json['posts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'owner': {'_id': ownerId},
      'location': location,
      'summary': summary,
      'education': education,
      'experience': experience,
      'status': status,
      'skills': skills,
      'profile_image': profileImage,
      'following': following,
      'followers': followers,
      'number_of_followers': numberOfFollowers,
      'number_of_following': numberOfFollowing,
      'posts': posts,
    };
  }
}

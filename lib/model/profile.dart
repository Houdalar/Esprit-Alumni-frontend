import 'dart:ffi';

class ProfileModel {
  final String owner;
  final String username;
  final String location;
  final String summary;
  final List<String> education;
  final String status;
  final List<String> experience;
  final List<String> skills;
  final String profileImage;
  final List<String> following;
  final List<String> followers;
  final int numberOfFollowers;
  final int numberOfFollowing;
  final List<String> posts;

  ProfileModel({
    required this.owner,
    required this.username,
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

  // Getter method for summary
  //String get summary => summary;

  // Setter method for summary
  set summary(String summary) {
    summary = summary;
  }

// convert json to dart object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      owner: json['owner'],
      username: json['username'],
      location: json['location'],
      summary: json['summary'],
      education: List<String>.from(json['education'].map((x) => x)),
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
// convert dart object to json
  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'username': username,
      'location': location,
      'summary': summary,
      'education': education,
      'status': status,
      'experience': experience,
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

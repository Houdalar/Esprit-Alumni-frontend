class SearchUser {
  final String username;
  final String profileId;
  final String profileImage;

  SearchUser(
      {required this.username,
      required this.profileId,
      required this.profileImage});

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      username: json['username'],
      profileId: json['profile']['_id'],
      profileImage: json['profile']['profile_image'],
    );
  }
}

class UserInfoModel {
  String? username;
  String? profileImage;

  UserInfoModel({this.username, this.profileImage});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['profile_image'] = profileImage;
    return data;
  }
}

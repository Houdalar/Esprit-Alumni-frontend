class User {
  final String email;
  final String password;
  final String username;
  final String googleUserId;
  final String token;
  final String gender;
  final String dateOfBirth;
  final String level;
  final String speciality;
  final String option;
  final String status;
  final String profile;

  User({
    required this.email,
    required this.password,
    required this.username,
    required this.googleUserId,
    required this.token,
    required this.gender,
    required this.dateOfBirth,
    required this.level,
    required this.speciality,
    required this.option,
    required this.status,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      username: json['username'],
      googleUserId: json['googleUserId'],
      token: json['token'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      level: json['level'],
      speciality: json['speciality'],
      option: json['option'],
      status: json['status'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'googleUserId': googleUserId,
      'token': token,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'level': level,
      'speciality': speciality,
      'option': option,
      'status': status,
      'profile': profile,
    };
  }
}

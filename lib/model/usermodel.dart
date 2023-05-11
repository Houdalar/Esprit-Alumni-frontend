class User {
  final String email;
  final String password;
  final String username;
  final String token;
  final String gender;
  final String dateOfBirth;
  final String level;
  final String speciality;
  final String option;
  final String status;
  final String profile;
  final String? id;

  User(
      {required this.email,
      required this.password,
      required this.username,
      required this.token,
      required this.gender,
      required this.dateOfBirth,
      required this.level,
      required this.speciality,
      required this.option,
      required this.status,
      required this.profile,
      required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      username: json['username'],
      token: json['token'],
      gender: json['gender'],
      dateOfBirth: json['dateofbirth'],
      level: json['level'],
      speciality: json['speciality'],
      option: json['option'],
      status: json['status'],
      profile: json['profile'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'token': token,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'level': level,
      'speciality': speciality,
      'option': option,
      'status': status,
      'profile': profile,
      'id': id,
    };
  }
}

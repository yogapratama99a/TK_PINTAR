class UserModel {
  
  final String? token;
  final String? role;
  final Map<String, dynamic> profile;

  UserModel({
    required this.token,
    required this.role,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      role: json['role'] ?? '',
      profile: json['profile'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'role': role,
      'profile': profile,
    };
  }
}

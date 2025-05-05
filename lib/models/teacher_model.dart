class TeacherModel {
  final int user_id;
  final int id;
  final String url;
  final String name;
  final String position;

  TeacherModel({
    required this.user_id,
    required this.id,
    required this.url,
    required this.name,
    required this.position,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      user_id: json['user_id'],
      id: json['id'],
      url: json['url'],
      name: json['name'],
      position: json['position'],
    );
  }
}

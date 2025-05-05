class Announcement {
  final int id;
  final int? teacherId;
  final String title;
  final String content;
  final DateTime date;
  final String to;
  final String teacherName; // Nama guru
  final String teacherPoisition;
  final String? teacherImageUrl; // URL gambar guru (optional)

  Announcement({
    required this.id,
    this.teacherId,
    required this.title,
    required this.content,
    required this.date,
    required this.to,
    required this.teacherName, // Guru
   required this.teacherPoisition,
    this.teacherImageUrl, // URL gambar (null jika tidak ada)
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
  return Announcement(
    id: json['id'],
   teacherId: json['teacher_id'], // bisa null
    title: json['title'],
    content: json['content'],
    date: DateTime.parse(json['date']),
    to: json['to'], // Tambahkan awalan
    teacherName: json['name'] ?? '',
    teacherPoisition: json['position'] ?? '',
    teacherImageUrl: json['url'],
  );
}

}

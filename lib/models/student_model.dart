class Student {
  final int user_id;
  final int id;
  final String name;
  final String? imageUrl;
  final String? className; // optional, kalau nggak ada hapus
  final String? number;
  final String? parentName;
  final String? parentPhone;
  final String? parentEmail;

  Student({
    required this.user_id,
    required this.id,
    required this.name,
    this.imageUrl,
    this.number,
    this.className,
    this.parentName,
    this.parentPhone,
    this.parentEmail,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    final studentJson = json['student'];
    final parentJson = json['parent'];

    return Student(
      id: studentJson['id'],
      name: studentJson['name'],
      number: studentJson['number'],
      imageUrl: studentJson['image_url'],
      className: '', // Kalau tidak ada className, isi kosong

      user_id: parentJson['user_id'],
      parentName: parentJson['name'],
      parentPhone: parentJson['phone_number'],
      parentEmail: parentJson['email'],
    );
  }
}

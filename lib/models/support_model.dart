class SupportModel {
  final String name;
  final String waNumber;

  SupportModel({required this.name, required this.waNumber});

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      name: json['name'] ?? '',
      waNumber: json['wa_number'] ?? '',
    );
  }
}
  
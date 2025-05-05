class LearningOutcomeModel {
  final String name;
  final String number;
  final String className;
  final String teacher;
  final String imageUrl; // Tambahkan field untuk imageUrl
  final List<LearningValue> values;

  LearningOutcomeModel({
    required this.name,
    required this.number,
    required this.className,
    required this.teacher,
    required this.imageUrl, // Sertakan imageUrl
    required this.values,
  });

  factory LearningOutcomeModel.fromJson(Map<String, dynamic> json) {
    return LearningOutcomeModel(
      name: json['student']['name'],
      number: json['student']['number'],
      className: json['student']['class']['name'],
      teacher: json['student']['class']['teacher'],
      imageUrl: json['student']['image_url'] ?? '', // Dapatkan image_url dari JSON
      values: List<LearningValue>.from(
        json['learning_outcomes'].map((val) => LearningValue.fromJson(val)),
      ),
    );
  }

  double get averageValue {
    if (values.isEmpty) return 0.0;
    return values.map((v) => v.value).reduce((a, b) => a + b) / values.length;
  }

  String get accreditation {
    return _getAccreditation(averageValue);
  }

  static String _getAccreditation(double avgValue) {
    if (avgValue >= 85) {
      return 'Sangat Baik';
    } else if (avgValue >= 70) {
      return 'Baik';
    } else if (avgValue >= 55) {
      return 'Cukup';
    } else {
      return 'Tidak Memadai';
    }
  }
}


class LearningValue {
  final String course;
  final double value;
  final String information;

  LearningValue({
    required this.course,
    required this.value,
    required this.information,
  });

  factory LearningValue.fromJson(Map<String, dynamic> json) {
    return LearningValue(
      course: json['course'],
      value: json['value'] is String
          ? double.tryParse(json['value']) ?? 0.0
          : (json['value'] is double ? json['value'] : 0.0),
      information: json['information'],
    );
  }
}

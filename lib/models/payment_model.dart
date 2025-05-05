class Payment {
  final String month;
  final String year; // Pastikan ini bukan nullable
  final String status;
  final String date;

  Payment({
    required this.month,
    required this.year,
    required this.status,
    required this.date,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      month: json['month'] ?? '-',
      year: json['year'] ?? '2024',
      status: json['status'] ?? 'Belum Lunas',
      date: json['date'] ?? '-',
    );
  }
}

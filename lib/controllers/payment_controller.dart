import 'package:get/get.dart';

import '../models/payment_model.dart';
import '../services/api_service.dart'; // Sesuaikan dengan path APIService Anda
class PaymentController extends GetxController {
  var studentName = ''.obs;
  var className = ''.obs;
  var studentNumber = ''.obs;
  var imageUrl = ''.obs; // Gambar siswa
  var payments = <Payment>[].obs;
  var selectedYear = '2024'.obs; // Menyimpan tahun yang dipilih

  @override
  void onInit() {
    super.onInit();
    getPaymentStatus(); // Panggil fungsi untuk mengambil data pembayaran
  }

  // Fungsi untuk mengambil status pembayaran dan data siswa
  Future<void> getPaymentStatus() async {
  try {
    var response = await ApiService.getPayment();

    if (response['success'] == true) {
      var data = response['data'];

      // Ambil data siswa
      studentName.value = data['student']['name'] ?? 'Nama tidak ditemukan';
      className.value = data['student']['class_name'] ?? '-';
      studentNumber.value = data['student']['number'] ?? '-';
      imageUrl.value = data['student']['image_url'] ?? '';

      // Ambil data pembayaran
      List<String> months = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];

      List<Payment> allPayments = [];

      // Tambahkan semua bulan meskipun tidak ada pembayaran
      for (var month in months) {
        var paymentData = data['payments'].firstWhere(
          (payment) => payment['month'] == month,
          orElse: () => null,
        );

        // Jika tidak ada data untuk bulan tersebut, buat status kosong
        if (paymentData == null) {
          allPayments.add(Payment(
            month: month,
            status: 'Belum Lunas',
            date: '-',
            year: data['payments'].isNotEmpty ? (data['payments'][0]['year'] ?? '2024') : '2024',
          ));
        } else {
          allPayments.add(Payment.fromJson(paymentData));
        }
      }

      payments.value = allPayments;
    } else {
      print('Error: ${response['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/payment_controller.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

import '../../models/payment_model.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

   PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.payments.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            _buildStudentCard(controller),
            _buildYearDropdown(controller),
            Expanded(child: _buildPaymentTable(controller)),
          ],
        );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Pembayaran",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: AppFonts.PoppinsBold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildStudentCard(PaymentController controller) {
    return Card(
      color: AppColors.blue,
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildStudentIcon(controller),
            const SizedBox(width: 12),
            _buildStudentInfo(controller),
          ],
        ),
      ),
    );
  }

  // Diperbaiki agar controller bisa digunakan
  Widget _buildStudentIcon(PaymentController controller) {
    return Obx(() {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue,
        backgroundImage: (controller.imageUrl.value.isNotEmpty)
            ? CachedNetworkImageProvider(controller.imageUrl.value)
            : null,
        child: (controller.imageUrl.value.isEmpty)
            ? const Icon(Icons.person, size: 30, color: Colors.blue)
            : null,
      );
    });
  }

  Widget _buildStudentInfo(PaymentController controller) {
    return Expanded(
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.studentName.value,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "Kelas ${controller.className.value} | No.Absen ${controller.studentNumber.value}",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget _buildYearDropdown(PaymentController controller) {
    List<String> years =
        controller.payments.map((payment) => payment.year).toSet().toList();

    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              "Tahun ${controller.selectedYear.value}",
              style: const TextStyle(
                fontFamily: AppFonts.PoppinsMedium,
              ),
            ),
            trailing: const Icon(Icons.arrow_drop_down, color: AppColors.green),
            onTap: () => _showYearPicker(controller, years),
          ),
        ));
  }

  Widget _buildPaymentTable(PaymentController controller) {
    List<Payment> filteredPayments = controller.payments
        .where((payment) => payment.year == controller.selectedYear.value)
        .toList();

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPayments.length,
              itemBuilder: (context, index) {
                Payment payment = filteredPayments[index];
                return _buildPaymentRow(payment);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TableHeader("Bulan"),
          _TableHeader("Status"),
          _TableHeader("Tanggal"),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(Payment payment) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TableCell(payment.month, 60),
          _TableCell(payment.status, 80,
              color: payment.status == 'Lunas' ? Colors.green : Colors.red),
          _TableCell(payment.date ?? '-', 60),
        ],
      ),
    );
  }

  void _showYearPicker(PaymentController controller, List<String> years) {
    Get.dialog(
      AlertDialog(
        title: const Text("Pilih Tahun"),
        content: _buildYearList(controller, years),
      ),
    );
  }

  Widget _buildYearList(PaymentController controller, List<String> years) {
    return SizedBox(
      width: double.minPositive,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: years.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(years[index]),
            onTap: () {
              controller.selectedYear.value = years[index];
              Get.back();
            },
          );
        },
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;

  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.PoppinsMedium,
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final double width;
  final Color? color;

  const _TableCell(this.text, this.width, {this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppFonts.PoppinsRegular,
          fontSize: 12,
          color: color,
        ),
      ),
    );
  }
}

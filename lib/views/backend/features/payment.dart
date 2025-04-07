import 'package:flutter/material.dart';
import 'package:tk_pertiwi/views/theme/app_colors.dart';
import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<String> _months = [
    "Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
    "Jul", "Agu", "Sep", "Okt", "Nov", "Des"
  ];

  String _selectedYear = '2024';
  final List<String> _years = ['2023', '2024', '2025'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      ),
      body: Column(
        children: [
          // Student Information Card
          _buildStudentCard(),
          
          // Year Dropdown
          _buildYearDropdown(),
          
          // Payment Table
          Expanded(
            child: _buildPaymentTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoText("Santoso Pratama"),
                  _InfoText("TK A1 | 2024/2025"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          "Tahun $_selectedYear",
          style: const TextStyle(
            fontFamily: AppFonts.PoppinsMedium,
          ),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: AppColors.green),
        onTap: () => _showYearPicker(context),
      ),
    );
  }

  Widget _buildPaymentTable() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: const BorderRadius.only(
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
          ),
          
          // Table Content
          Expanded(
            child: ListView.builder(
              itemCount: _months.length,
              itemBuilder: (context, index) {
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
                      _TableCell(_months[index], 60),
                      _TableCell("Lunas", 60, color: AppColors.green),
                      _TableCell("10/${index+1}/$_selectedYear", 80),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Tahun"),
          content: SizedBox(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _years.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_years[index]),
                  onTap: () {
                    setState(() {
                      _selectedYear = _years[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _InfoText extends StatelessWidget {
  final String text;
  
  const _InfoText(this.text);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: AppFonts.PoppinsRegular,
        fontSize: 12,
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
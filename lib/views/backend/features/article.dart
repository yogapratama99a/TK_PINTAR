import 'package:flutter/material.dart';

import 'package:tk_pertiwi/views/theme/app_fonts.dart';

class ArticleScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const ArticleScreen({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artikel',
          style: TextStyle(
            fontFamily: AppFonts.PoppinsBold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Ensure text is visible on gradient
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E88E5), // Light blue
                Color(0xFF0D47A1), // Dark blue
              ],
            ),
          ),
        ),
        foregroundColor: Colors.white, // For icons and back button
        elevation: 0,
        toolbarHeight: kToolbarHeight, // Standard height
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar Fasilitas
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Deskripsi Artikel
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontFamily: AppFonts.PoppinsRegular,
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

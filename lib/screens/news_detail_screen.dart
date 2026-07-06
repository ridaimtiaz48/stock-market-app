import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String summary;
  final String source;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEDC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5EEDC),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(source, style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl),
              ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(summary, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

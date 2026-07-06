import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> symbols = ['AAPL', 'TSLA', 'GOOGL'];
  final Map<String, List<dynamic>> newsBySymbol = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStockNews();
  }

  Future<void> fetchStockNews() async {
    setState(() => isLoading = true);
    const apiKey = 'd14s3spr01qop9mf6b10d14s3spr01qop9mf6b1g';
    final now = DateTime.now();
    final from = now.subtract(Duration(days: 3)).toIso8601String().substring(0, 10);
    final to = now.toIso8601String().substring(0, 10);

    try {
      for (String symbol in symbols) {
        final url = 'https://finnhub.io/api/v1/company-news?symbol=$symbol&from=$from&to=$to&token=$apiKey';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final List<dynamic> news = json.decode(response.body);
          newsBySymbol[symbol] = news;
        }
      }
    } catch (e) {
      debugPrint("Error fetching company news: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEDC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5EEDC),
        elevation: 0,
        title: Text(
          'Stock News',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchStockNews,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: symbols.map((symbol) {
            final newsList = newsBySymbol[symbol] ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getCompanyName(symbol),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...newsList.take(3).map((item) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: item['image'] != null && item['image'] != ""
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(Icons.article, size: 48),
                      title: Text(
                        item['headline'] ?? 'No Title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      subtitle: Text(
                        item['source'] ?? '',
                        style: TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailScreen(
                              title: item['headline'] ?? '',
                              imageUrl: item['image'] ?? '',
                              summary: item['summary'] ?? '',
                              source: item['source'] ?? '',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String getCompanyName(String symbol) {
    switch (symbol) {
      case 'AAPL':
        return 'Apple Inc.';
      case 'TSLA':
        return 'Tesla Inc.';
      case 'GOOGL':
        return 'Alphabet Inc.';
      default:
        return symbol;
    }
  }
}

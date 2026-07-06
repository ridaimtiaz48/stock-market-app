import 'dart:convert';
import 'package:http/http.dart' as http;

class StockService {
  static const String _apiKey = 'd14s3spr01qop9mf6b10d14s3spr01qop9mf6b1g';
  static const String _baseUrl = 'https://finnhub.io/api/v1';

  static Future<Map<String, dynamic>> fetchQuote(String symbol) async {
    final url = '$_baseUrl/quote?symbol=$symbol&token=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load quote');
    }
  }

  static Future<String> fetchLogo(String symbol) async {
    final url = '$_baseUrl/stock/profile2?symbol=$symbol&token=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['logo'] ?? '';
    } else {
      throw Exception('Failed to load logo');
    }
  }
}

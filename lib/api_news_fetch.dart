import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApiClient {
  final String baseUrl = 'https://reelnews-api-fe5e8d8c10e8.herokuapp.com';

  Future<List<dynamic>> getTopHeadlines({String country = 'us'}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=$country'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['articles'] ?? [];
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<List<dynamic>> getEverything({String query = 'bitcoin'}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/everything?q=$query'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['articles'] ?? [];
    } else {
      throw Exception('Failed to load everything news');
    }
  }

  Future<List<dynamic>> getSources() async {
    final response = await http.get(
      Uri.parse('$baseUrl/sources'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['sources'] ?? [];
    } else {
      throw Exception('Failed to load news sources');
    }
  }
}

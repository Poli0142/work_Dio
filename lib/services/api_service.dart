import 'package:dio/dio.dart';
import '../di.dart';

class ApiService {
  final Dio _dio = getIt<Dio>();

  Future<Map<String, dynamic>> getCryptoPrice(String symbol) async {
    final response = await _dio.get(
      '/cryptoprice',
      queryParameters: {'symbol': symbol},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getRandomHobbies() async {
    final response = await _dio.get('/hobbies');
    return response.data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getRandomTrivia() async {
    final response = await _dio.get('/trivia');
    return response.data as List<dynamic>;
  }
}
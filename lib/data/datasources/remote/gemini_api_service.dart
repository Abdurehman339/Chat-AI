import 'package:chat_ai/domain/entities/response/content.dart';
import 'package:chat_ai/utils/constants/api_key.dart';
import 'package:dio/dio.dart';

class GeminiApiService {
  Future<Response<dynamic>> chatTextGeneration(
      List<Content> previousMessages) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey',
        data: {
          'contents': previousMessages.map((e) => e.toJson()).toList(),
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

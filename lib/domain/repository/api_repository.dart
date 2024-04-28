import 'package:chat_ai/domain/entities/response/api_response.dart';
import 'package:chat_ai/domain/entities/response/content.dart';
import 'package:chat_ai/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<ApiResponse>> getResponse({
    required List<Content> request,
  });
}

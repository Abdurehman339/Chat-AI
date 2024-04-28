import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:chat_ai/data/datasources/remote/gemini_api_service.dart';
import 'package:chat_ai/data/repository/api_repository_impl.dart';
import 'package:chat_ai/domain/repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependecies() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<GeminiApiService>(
    GeminiApiService(),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImp(locator<GeminiApiService>()),
  );
}

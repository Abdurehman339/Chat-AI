// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class DataState<T> {
  final T? data;
  final DioException? error;
  const DataState({
    this.data,
    this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({super.data});
}

class DataFailed<T> extends DataState<T> {
  const DataFailed({super.error});
}

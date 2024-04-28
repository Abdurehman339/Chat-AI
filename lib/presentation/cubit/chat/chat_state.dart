import 'package:chat_ai/domain/entities/response/content.dart';
import 'package:equatable/equatable.dart';

class ChatSuccessState extends Equatable {
  final bool isLoading;
  final List<Content> messages;
  const ChatSuccessState({
    required this.isLoading,
    this.messages = const [],
  });

  @override
  List<Object?> get props => [isLoading];
}

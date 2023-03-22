import 'package:dartz/dartz.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_remote_service.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/extensions.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/resquests/create_chat_message_request.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

class ChatMessageRepository {
  ChatMessageRepository({
    required ChatMessageRemoteService chatMessageRemoteService,
  }) : _chatMessageRemoteService = chatMessageRemoteService;

  final ChatMessageRemoteService _chatMessageRemoteService;

  Future<Either<ChatFailure, List<ChatMessageEntity>>> getAllMessages({
    required String chatId,
  }) async {
    final response = await _chatMessageRemoteService.getAllMessages(
      chatId: chatId,
    );

    if (response.success && response.data != null) {
      return right(response.data!.toDomainList());
    }

    return left(ChatFailure.api(response.statusCode, response.message));
  }

  Future<Either<ChatFailure, ChatMessageEntity>> createChatMessage({
    required String content,
    required String chatId,
  }) async {
    final response = await _chatMessageRemoteService.createChatMessage(
      CreateChatMessageRequest(chatId: chatId, content: content),
    );

    if (response.success && response.data != null) {
      return right(response.data!.toDomain());
    }

    return left(ChatFailure.api(response.statusCode, response.message));
  }
}

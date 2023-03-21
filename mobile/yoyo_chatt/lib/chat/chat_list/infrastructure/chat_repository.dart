import 'package:dartz/dartz.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_remote_service.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/extensions.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/requests/create_chat_request.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/requests/create_group_chat_request.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

import '../domain/chat_model.dart';

class ChatRepository {
  ChatRepository({
    required ChatRemoteService chatRemoteService,
  }) : _chatRemoteService = chatRemoteService;

  final ChatRemoteService _chatRemoteService;

  Future<Either<ChatFailure, List<ChatEntity>>> getChats() async {
    final response = await _chatRemoteService.getChats();

    if (response.success && response.data != null) {
      return right(response.data!.toDomainList());
    }

    return left(ChatFailure.api(response.statusCode, response.statusMessage));
  }

  Future<Either<ChatFailure, ChatEntity>> createGroupOrAccessChat({
    required String name,
    required List<String> users,
  }) async {
    final response = await _chatRemoteService.createGroupOrAccessChat(
      CreateGroupChatRequest(name: name, users: users),
    );

    if (response.success && response.data != null) {
      return right(response.data!.toDomain());
    }

    return left(ChatFailure.api(response.statusCode, response.statusMessage));
  }

  Future<Either<ChatFailure, ChatEntity>> createOrAccessChat({
    required String userId,
  }) async {
    final response = await _chatRemoteService.createOrAccessChat(
      CreateChatRequest(userId: userId),
    );

    if (response.success && response.data != null) {
      return right(response.data!.toDomain());
    }

    return left(ChatFailure.api(response.statusCode, response.statusMessage));
  }
}

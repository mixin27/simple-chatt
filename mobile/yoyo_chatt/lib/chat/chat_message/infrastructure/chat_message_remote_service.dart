import 'package:dio/dio.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_dto.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/resquests/create_chat_message_request.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';
import 'package:yoyo_chatt/core/utils/endpoints.dart';

class ChatMessageRemoteService {
  ChatMessageRemoteService({
    Dio? dioClient,
  }) : _dioClient = dioClient ??= DioClient().instance;

  final Dio _dioClient;

  Future<AppResponse<List<ChatMessageDto>>> getAllMessages({
    required String chatId,
  }) async {
    final response = await _dioClient.get('${Endpoints.message}/$chatId');

    return AppResponse<List<ChatMessageDto>>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? (json as List<dynamic>)
              .map((e) => ChatMessageDto.fromJson(e))
              .toList()
          : [],
    );
  }

  Future<AppResponse<ChatMessageDto?>> createChatMessage(
      CreateChatMessageRequest request) async {
    final response = await _dioClient.post(
      Endpoints.message,
      data: request.toJson(),
    );

    return AppResponse<ChatMessageDto?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatMessageDto.fromJson(json)
          : null,
    );
  }
}

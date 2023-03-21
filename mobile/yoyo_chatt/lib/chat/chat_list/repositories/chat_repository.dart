import 'package:dio/dio.dart';
import 'package:yoyo_chatt/chat/chat_list/models/requests/create_group_chat_request.dart';
import 'package:yoyo_chatt/chat/chat_list/models/requests/create_chat_request.dart';
import 'package:yoyo_chatt/chat/chat_list/models/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/repositories/base_chat_repository.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';
import 'package:yoyo_chatt/core/utils/endpoints.dart';

class ChatRepository implements BaseChatRepository {
  ChatRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ?? DioClient().instance;

  final Dio _dioClient;

  @override
  Future<AppResponse<List<ChatEntity>>> getChats() async {
    final response = await _dioClient.get(Endpoints.fetchingChats);

    return AppResponse<List<ChatEntity>>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? (json as List<dynamic>).map((e) => ChatEntity.fromJson(e)).toList()
          : [],
    );
  }

  @override
  Future<AppResponse<ChatEntity?>> createOrAccessChat(
      CreateChatRequest request) async {
    final response = await _dioClient.post(
      Endpoints.createOrAccessChat,
      data: request.toJson(),
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatEntity.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse<ChatEntity?>> createGroupOrAccessChat(
      CreateGroupChatRequest request) async {
    final response = await _dioClient.post(
      Endpoints.createGroupOrAccessChat,
      data: request.toJson(),
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatEntity.fromJson(json)
          : null,
    );
  }
}

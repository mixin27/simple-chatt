import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_dto.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/requests/create_chat_request.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/requests/create_group_chat_request.dart';
import 'package:yoyo_chatt/core/http/dio_client.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

import '../../../core/utils/endpoints.dart';

class ChatRemoteService {
  ChatRemoteService({
    Dio? dioClient,
  }) : _dioClient = dioClient ??= DioClient().instance;

  final Dio _dioClient;

  Future<AppResponse<List<ChatDto>>> getChats() async {
    final response = await _dioClient.get(Endpoints.fetchingChats);

    return AppResponse<List<ChatDto>>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? (json as List<dynamic>).map((e) => ChatDto.fromJson(e)).toList()
          : [],
    );
  }

  Future<AppResponse<ChatDto?>> createGroupOrAccessChat(
      CreateGroupChatRequest request) async {
    final payload = {
      "name": request.name,
      "users": jsonEncode([
        ...request.users,
      ]),
    };

    final response = await _dioClient.post(
      Endpoints.createGroupOrAccessChat,
      data: payload,
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatDto.fromJson(json)
          : null,
    );
  }

  Future<AppResponse<ChatDto?>> createOrAccessChat(
      CreateChatRequest request) async {
    final response = await _dioClient.post(
      Endpoints.createOrAccessChat,
      data: request.toJson(),
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? ChatDto.fromJson(json)
          : null,
    );
  }

  // @override
  // Future<AppResponse<ChatEntity?>> createOrAccessChat(
  //     CreateChatRequest request) async {
  //   final response = await _dioClient.post(
  //     Endpoints.createOrAccessChat,
  //     data: request.toJson(),
  //   );

  //   return AppResponse.fromJson(
  //     response.data,
  //     (dynamic json) => response.data['success'] && json != null
  //         ? ChatEntity.fromJson(json)
  //         : null,
  //   );
  // }

  // @override
  // Future<AppResponse<ChatEntity?>> createGroupOrAccessChat(
  //     CreateGroupChatRequest request) async {
  //   final response = await _dioClient.post(
  //     Endpoints.createGroupOrAccessChat,
  //     data: request.toJson(),
  //   );

  //   return AppResponse.fromJson(
  //     response.data,
  //     (dynamic json) => response.data['success'] && json != null
  //         ? ChatEntity.fromJson(json)
  //         : null,
  //   );
  // }
}

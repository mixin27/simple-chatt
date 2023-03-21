import 'package:yoyo_chatt/chat/chat_list/models/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/models/requests/create_chat_request.dart';
import 'package:yoyo_chatt/core/models/app_response.dart';

import '../models/requests/create_group_chat_request.dart';

abstract class BaseChatRepository {
  Future<AppResponse<List<ChatEntity>>> getChats();

  Future<AppResponse<ChatEntity?>> createOrAccessChat(
      CreateChatRequest request);

  Future<AppResponse<ChatEntity?>> createGroupOrAccessChat(
      CreateGroupChatRequest request);
}

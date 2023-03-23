import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/core/utils/formatting.dart';

part 'chat_message_model.freezed.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const ChatMessageEntity._();

  const factory ChatMessageEntity({
    required String id,
    required String content,
    required String createdAt,
    required String updatedAt,
    required UserEntity sender,
    dynamic chat,
  }) = _ChatMessageEntity;

  ChatMessage get toChatMessage {
    return ChatMessage(
      user: sender.toChatUser,
      createdAt: parseDateTime(createdAt),
      text: content,
    );
  }
}

extension ChatMessageEntityListX on List<ChatMessageEntity> {
  List<ChatMessage> get uiChatMessages => map((e) => e.toChatMessage).toList();
}

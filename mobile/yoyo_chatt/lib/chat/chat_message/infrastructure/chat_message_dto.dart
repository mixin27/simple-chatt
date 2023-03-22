import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_dto.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';

part 'chat_message_dto.freezed.dart';
part 'chat_message_dto.g.dart';

@freezed
class ChatMessageDto with _$ChatMessageDto {
  const ChatMessageDto._();
  const factory ChatMessageDto({
    @JsonKey(name: "_id") required String id,
    required String content,
    required String createdAt,
    required String updatedAt,
    required UserEntity sender,
    required ChatDto chat,
  }) = _ChatMessageDto;

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);

  ChatMessageEntity toDomain() => ChatMessageEntity(
        id: id,
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt,
        sender: sender,
        chat: chat.toDomain(),
      );
}

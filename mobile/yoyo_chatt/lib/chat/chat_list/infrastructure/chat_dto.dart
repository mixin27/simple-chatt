import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';

import '../domain/chat_model.dart';

part 'chat_dto.freezed.dart';
part 'chat_dto.g.dart';

@freezed
class ChatDto with _$ChatDto {
  const ChatDto._();

  const factory ChatDto({
    @JsonKey(name: "_id") required String id,
    required String name,
    @JsonKey(name: "is_group_chat") required bool isGroupChat,
    @Default([]) @JsonKey(defaultValue: []) List<UserEntity> users,
    @JsonKey(name: "group_admin") UserEntity? groupAdmin,
    required String createdAt,
    required String updatedAt,
  }) = _ChatDto;

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  ChatEntity toDomain() => ChatEntity(
        id: id,
        name: name,
        isGroupChat: isGroupChat,
        users: users,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

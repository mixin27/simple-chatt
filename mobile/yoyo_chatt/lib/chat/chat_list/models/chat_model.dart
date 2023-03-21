import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    @JsonKey(name: "_id") required String id,
    required String name,
    @JsonKey(name: "is_group_chat") required bool isGroupChat,
    @Default([]) @JsonKey(defaultValue: []) List<UserEntity> users,
    @JsonKey(name: "group_admin") UserEntity? groupAdmin,
    required String createdAt,
    required String updatedAt,
  }) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yoyo_chatt/auth/models/credential.dart';

part 'chat_model.freezed.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const ChatEntity._();

  const factory ChatEntity({
    required String id,
    required String name,
    required bool isGroupChat,
    @Default([]) List<UserEntity> users,
    UserEntity? groupAdmin,
    required String createdAt,
    required String updatedAt,
  }) = _ChatEntity;
}

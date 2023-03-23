import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_group_chat_request.freezed.dart';
part 'create_group_chat_request.g.dart';

@freezed
class CreateGroupChatRequest with _$CreateGroupChatRequest {
  const factory CreateGroupChatRequest({
    required String name,
    required List<String> users,
  }) = _CreateGroupChatRequest;

  factory CreateGroupChatRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupChatRequestFromJson(json);
}

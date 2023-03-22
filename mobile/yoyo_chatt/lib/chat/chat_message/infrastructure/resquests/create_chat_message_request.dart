import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat_message_request.freezed.dart';
part 'create_chat_message_request.g.dart';

@freezed
class CreateChatMessageRequest with _$CreateChatMessageRequest {
  const factory CreateChatMessageRequest({
    required String chatId,
    required String content,
  }) = _CreateChatMessageRequest;

  factory CreateChatMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatMessageRequestFromJson(json);
}

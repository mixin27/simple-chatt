import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat_request.freezed.dart';
part 'create_chat_request.g.dart';

@freezed
class CreateChatRequest with _$CreateChatRequest {
  const factory CreateChatRequest({
    required String userId,
  }) = _CreateChatRequest;

  factory CreateChatRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRequestFromJson(json);
}

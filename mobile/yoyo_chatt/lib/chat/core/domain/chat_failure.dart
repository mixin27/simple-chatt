import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_failure.freezed.dart';

@freezed
class ChatFailure with _$ChatFailure {
  const factory ChatFailure.api(
    int? errorCode,
    String? message,
  ) = _Api;
}

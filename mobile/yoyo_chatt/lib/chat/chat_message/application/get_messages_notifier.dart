import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_repository.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

part 'get_messages_notifier.freezed.dart';

@freezed
class GetMessagesState with _$GetMessagesState {
  const factory GetMessagesState.initial() = _Initial;
  const factory GetMessagesState.loading() = _Loading;
  const factory GetMessagesState.empty() = _Empty;
  const factory GetMessagesState.success(List<ChatMessageEntity> messages) =
      _Success;
  const factory GetMessagesState.error(ChatFailure failure) = _Error;
}

class GetMessagesNotifier extends StateNotifier<GetMessagesState> {
  GetMessagesNotifier({
    required ChatMessageRepository chatMessageRepository,
  })  : _chatMessageRepository = chatMessageRepository,
        super(const GetMessagesState.initial());

  final ChatMessageRepository _chatMessageRepository;

  Future<void> getAllMessages({
    required String chatId,
  }) async {
    state = const GetMessagesState.loading();

    final fos = await _chatMessageRepository.getAllMessages(chatId: chatId);

    state = fos.fold(
      (l) => GetMessagesState.error(l),
      (r) => r.isEmpty
          ? const GetMessagesState.empty()
          : GetMessagesState.success(r),
    );
  }
}

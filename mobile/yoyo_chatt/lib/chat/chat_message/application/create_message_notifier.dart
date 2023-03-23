import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_repository.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

part 'create_message_notifier.freezed.dart';

@freezed
class CreateMessageState with _$CreateMessageState {
  const factory CreateMessageState.initial() = _Initial;
  const factory CreateMessageState.loading() = _Loading;
  const factory CreateMessageState.success(ChatMessageEntity message) =
      _Success;
  const factory CreateMessageState.error(ChatFailure failure) = _Error;
}

class CreateMessageNotifier extends StateNotifier<CreateMessageState> {
  CreateMessageNotifier({
    required ChatMessageRepository chatMessageRepository,
  })  : _chatMessageRepository = chatMessageRepository,
        super(const CreateMessageState.initial());

  final ChatMessageRepository _chatMessageRepository;

  Future<void> sendMessage({
    required String content,
    required String chatId,
  }) async {
    state = const CreateMessageState.loading();

    final fos = await _chatMessageRepository.createChatMessage(
      content: content,
      chatId: chatId,
    );

    state = fos.fold(
      (l) => CreateMessageState.error(l),
      (r) => CreateMessageState.success(r),
    );
  }
}

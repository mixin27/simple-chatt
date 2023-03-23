import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_repository.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

part 'create_or_access_chat_notifier.freezed.dart';

@freezed
class CreateOrAccessChatState with _$CreateOrAccessChatState {
  const factory CreateOrAccessChatState.initial() = _Initial;
  const factory CreateOrAccessChatState.loading() = _Loading;
  const factory CreateOrAccessChatState.success(ChatEntity chat) = _Success;
  const factory CreateOrAccessChatState.error(ChatFailure failure) = _Error;
}

class CreateOrAccessChatNotifier
    extends StateNotifier<CreateOrAccessChatState> {
  CreateOrAccessChatNotifier({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const CreateOrAccessChatState.initial());

  final ChatRepository _chatRepository;

  Future<void> createOrAccessChat({
    required String userId,
  }) async {
    state = const CreateOrAccessChatState.loading();

    final fos = await _chatRepository.createOrAccessChat(userId: userId);

    state = fos.fold(
      (l) => CreateOrAccessChatState.error(l),
      (r) => CreateOrAccessChatState.success(r),
    );
  }
}

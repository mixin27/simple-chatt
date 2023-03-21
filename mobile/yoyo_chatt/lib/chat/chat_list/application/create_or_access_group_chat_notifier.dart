import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_repository.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

part 'create_or_access_group_chat_notifier.freezed.dart';

@freezed
class CreateOrAccessGroupChatState with _$CreateOrAccessGroupChatState {
  const factory CreateOrAccessGroupChatState.initial() = _Initial;
  const factory CreateOrAccessGroupChatState.loading() = _Loading;
  const factory CreateOrAccessGroupChatState.success(ChatEntity chat) =
      _Success;
  const factory CreateOrAccessGroupChatState.error(ChatFailure failure) =
      _Error;
}

class CreateOrAccessGroupChatNotifier
    extends StateNotifier<CreateOrAccessGroupChatState> {
  CreateOrAccessGroupChatNotifier({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const CreateOrAccessGroupChatState.initial());

  final ChatRepository _chatRepository;

  Future<void> createOrAccessGroupChat({
    required String name,
    required List<String> userIds,
  }) async {
    state = const CreateOrAccessGroupChatState.loading();

    final fos = await _chatRepository.createGroupOrAccessChat(
      name: name,
      users: userIds,
    );

    state = fos.fold(
      (l) => CreateOrAccessGroupChatState.error(l),
      (r) => CreateOrAccessGroupChatState.success(r),
    );
  }
}

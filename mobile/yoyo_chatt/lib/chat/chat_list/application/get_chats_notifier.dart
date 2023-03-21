import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_repository.dart';
import 'package:yoyo_chatt/chat/core/domain/chat_failure.dart';

import '../domain/chat_model.dart';

part 'get_chats_notifier.freezed.dart';

@freezed
class GetChatsState with _$GetChatsState {
  const factory GetChatsState.initial() = _Initial;
  const factory GetChatsState.loading() = _Loading;
  const factory GetChatsState.empty() = _Empty;
  const factory GetChatsState.success(List<ChatEntity> chats) = _Success;
  const factory GetChatsState.error(ChatFailure failure) = _Error;
}

class GetChatsNotifier extends StateNotifier<GetChatsState> {
  GetChatsNotifier({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const GetChatsState.initial());

  final ChatRepository _chatRepository;

  Future<void> getAllChats() async {
    state = const GetChatsState.loading();

    final fos = await _chatRepository.getChats();

    state = fos.fold(
      (l) => GetChatsState.error(l),
      (r) => r.isEmpty ? const GetChatsState.empty() : GetChatsState.success(r),
    );
  }
}

import 'package:yoyo_chatt/chat/chat_list/domain/chat_model.dart';
import 'package:yoyo_chatt/chat/chat_list/infrastructure/chat_dto.dart';

extension ChatDtoListX on List<ChatDto> {
  List<ChatEntity> toDomainList() => map((e) => e.toDomain()).toList();
}

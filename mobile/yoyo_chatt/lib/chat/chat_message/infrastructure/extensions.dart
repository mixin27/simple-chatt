import 'package:yoyo_chatt/chat/chat_message/domain/chat_message_model.dart';
import 'package:yoyo_chatt/chat/chat_message/infrastructure/chat_message_dto.dart';

extension ChatMessageDtoListX on List<ChatMessageDto> {
  List<ChatMessageEntity> toDomainList() => map((e) => e.toDomain()).toList();
}

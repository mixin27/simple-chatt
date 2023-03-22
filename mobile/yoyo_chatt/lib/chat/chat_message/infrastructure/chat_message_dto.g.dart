// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessageDto _$$_ChatMessageDtoFromJson(Map<String, dynamic> json) =>
    _$_ChatMessageDto(
      id: json['_id'] as String,
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      sender: UserEntity.fromJson(json['sender'] as Map<String, dynamic>),
      chat: ChatDto.fromJson(json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ChatMessageDtoToJson(_$_ChatMessageDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'sender': instance.sender.toJson(),
      'chat': instance.chat.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_chat_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateGroupChatRequest _$$_CreateGroupChatRequestFromJson(
        Map<String, dynamic> json) =>
    _$_CreateGroupChatRequest(
      name: json['name'] as String,
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_CreateGroupChatRequestToJson(
        _$_CreateGroupChatRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'users': instance.users,
    };

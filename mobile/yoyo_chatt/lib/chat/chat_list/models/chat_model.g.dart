// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatEntity _$$_ChatEntityFromJson(Map<String, dynamic> json) =>
    _$_ChatEntity(
      id: json['_id'] as String,
      name: json['name'] as String,
      isGroupChat: json['is_group_chat'] as bool,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      groupAdmin: json['group_admin'] == null
          ? null
          : UserEntity.fromJson(json['group_admin'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$_ChatEntityToJson(_$_ChatEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'is_group_chat': instance.isGroupChat,
      'users': instance.users.map((e) => e.toJson()).toList(),
      'group_admin': instance.groupAdmin?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

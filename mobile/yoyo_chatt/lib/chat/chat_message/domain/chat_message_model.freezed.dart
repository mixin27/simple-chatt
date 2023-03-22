// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatMessageEntity {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  UserEntity get sender => throw _privateConstructorUsedError;
  ChatEntity get chat => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatMessageEntityCopyWith<ChatMessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageEntityCopyWith<$Res> {
  factory $ChatMessageEntityCopyWith(
          ChatMessageEntity value, $Res Function(ChatMessageEntity) then) =
      _$ChatMessageEntityCopyWithImpl<$Res, ChatMessageEntity>;
  @useResult
  $Res call(
      {String id,
      String content,
      String createdAt,
      String updatedAt,
      UserEntity sender,
      ChatEntity chat});

  $UserEntityCopyWith<$Res> get sender;
  $ChatEntityCopyWith<$Res> get chat;
}

/// @nodoc
class _$ChatMessageEntityCopyWithImpl<$Res, $Val extends ChatMessageEntity>
    implements $ChatMessageEntityCopyWith<$Res> {
  _$ChatMessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sender = null,
    Object? chat = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      chat: null == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatEntity,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get sender {
    return $UserEntityCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatEntityCopyWith<$Res> get chat {
    return $ChatEntityCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatMessageEntityCopyWith<$Res>
    implements $ChatMessageEntityCopyWith<$Res> {
  factory _$$_ChatMessageEntityCopyWith(_$_ChatMessageEntity value,
          $Res Function(_$_ChatMessageEntity) then) =
      __$$_ChatMessageEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String content,
      String createdAt,
      String updatedAt,
      UserEntity sender,
      ChatEntity chat});

  @override
  $UserEntityCopyWith<$Res> get sender;
  @override
  $ChatEntityCopyWith<$Res> get chat;
}

/// @nodoc
class __$$_ChatMessageEntityCopyWithImpl<$Res>
    extends _$ChatMessageEntityCopyWithImpl<$Res, _$_ChatMessageEntity>
    implements _$$_ChatMessageEntityCopyWith<$Res> {
  __$$_ChatMessageEntityCopyWithImpl(
      _$_ChatMessageEntity _value, $Res Function(_$_ChatMessageEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sender = null,
    Object? chat = null,
  }) {
    return _then(_$_ChatMessageEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      chat: null == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatEntity,
    ));
  }
}

/// @nodoc

class _$_ChatMessageEntity extends _ChatMessageEntity {
  const _$_ChatMessageEntity(
      {required this.id,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.sender,
      required this.chat})
      : super._();

  @override
  final String id;
  @override
  final String content;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final UserEntity sender;
  @override
  final ChatEntity chat;

  @override
  String toString() {
    return 'ChatMessageEntity(id: $id, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, sender: $sender, chat: $chat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.chat, chat) || other.chat == chat));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, createdAt, updatedAt, sender, chat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageEntityCopyWith<_$_ChatMessageEntity> get copyWith =>
      __$$_ChatMessageEntityCopyWithImpl<_$_ChatMessageEntity>(
          this, _$identity);
}

abstract class _ChatMessageEntity extends ChatMessageEntity {
  const factory _ChatMessageEntity(
      {required final String id,
      required final String content,
      required final String createdAt,
      required final String updatedAt,
      required final UserEntity sender,
      required final ChatEntity chat}) = _$_ChatMessageEntity;
  const _ChatMessageEntity._() : super._();

  @override
  String get id;
  @override
  String get content;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  UserEntity get sender;
  @override
  ChatEntity get chat;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageEntityCopyWith<_$_ChatMessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

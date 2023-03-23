// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessageDto _$ChatMessageDtoFromJson(Map<String, dynamic> json) {
  return _ChatMessageDto.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageDto {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  UserEntity get sender => throw _privateConstructorUsedError;
  dynamic get chat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageDtoCopyWith<ChatMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDtoCopyWith<$Res> {
  factory $ChatMessageDtoCopyWith(
          ChatMessageDto value, $Res Function(ChatMessageDto) then) =
      _$ChatMessageDtoCopyWithImpl<$Res, ChatMessageDto>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      String content,
      String createdAt,
      String updatedAt,
      UserEntity sender,
      dynamic chat});

  $UserEntityCopyWith<$Res> get sender;
}

/// @nodoc
class _$ChatMessageDtoCopyWithImpl<$Res, $Val extends ChatMessageDto>
    implements $ChatMessageDtoCopyWith<$Res> {
  _$ChatMessageDtoCopyWithImpl(this._value, this._then);

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
    Object? chat = freezed,
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
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get sender {
    return $UserEntityCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatMessageDtoCopyWith<$Res>
    implements $ChatMessageDtoCopyWith<$Res> {
  factory _$$_ChatMessageDtoCopyWith(
          _$_ChatMessageDto value, $Res Function(_$_ChatMessageDto) then) =
      __$$_ChatMessageDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      String content,
      String createdAt,
      String updatedAt,
      UserEntity sender,
      dynamic chat});

  @override
  $UserEntityCopyWith<$Res> get sender;
}

/// @nodoc
class __$$_ChatMessageDtoCopyWithImpl<$Res>
    extends _$ChatMessageDtoCopyWithImpl<$Res, _$_ChatMessageDto>
    implements _$$_ChatMessageDtoCopyWith<$Res> {
  __$$_ChatMessageDtoCopyWithImpl(
      _$_ChatMessageDto _value, $Res Function(_$_ChatMessageDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? sender = null,
    Object? chat = freezed,
  }) {
    return _then(_$_ChatMessageDto(
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
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatMessageDto extends _ChatMessageDto {
  const _$_ChatMessageDto(
      {@JsonKey(name: "_id") required this.id,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.sender,
      this.chat})
      : super._();

  factory _$_ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$$_ChatMessageDtoFromJson(json);

  @override
  @JsonKey(name: "_id")
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
  final dynamic chat;

  @override
  String toString() {
    return 'ChatMessageDto(id: $id, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, sender: $sender, chat: $chat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessageDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            const DeepCollectionEquality().equals(other.chat, chat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, createdAt,
      updatedAt, sender, const DeepCollectionEquality().hash(chat));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageDtoCopyWith<_$_ChatMessageDto> get copyWith =>
      __$$_ChatMessageDtoCopyWithImpl<_$_ChatMessageDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageDtoToJson(
      this,
    );
  }
}

abstract class _ChatMessageDto extends ChatMessageDto {
  const factory _ChatMessageDto(
      {@JsonKey(name: "_id") required final String id,
      required final String content,
      required final String createdAt,
      required final String updatedAt,
      required final UserEntity sender,
      final dynamic chat}) = _$_ChatMessageDto;
  const _ChatMessageDto._() : super._();

  factory _ChatMessageDto.fromJson(Map<String, dynamic> json) =
      _$_ChatMessageDto.fromJson;

  @override
  @JsonKey(name: "_id")
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
  dynamic get chat;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageDtoCopyWith<_$_ChatMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

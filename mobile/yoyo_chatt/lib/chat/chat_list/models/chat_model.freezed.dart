// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) {
  return _ChatEntity.fromJson(json);
}

/// @nodoc
mixin _$ChatEntity {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "is_group_chat")
  bool get isGroupChat => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: [])
  List<UserEntity> get users => throw _privateConstructorUsedError;
  @JsonKey(name: "group_admin")
  UserEntity? get groupAdmin => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatEntityCopyWith<ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEntityCopyWith<$Res> {
  factory $ChatEntityCopyWith(
          ChatEntity value, $Res Function(ChatEntity) then) =
      _$ChatEntityCopyWithImpl<$Res, ChatEntity>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      String name,
      @JsonKey(name: "is_group_chat") bool isGroupChat,
      @JsonKey(defaultValue: []) List<UserEntity> users,
      @JsonKey(name: "group_admin") UserEntity? groupAdmin,
      String createdAt,
      String updatedAt});

  $UserEntityCopyWith<$Res>? get groupAdmin;
}

/// @nodoc
class _$ChatEntityCopyWithImpl<$Res, $Val extends ChatEntity>
    implements $ChatEntityCopyWith<$Res> {
  _$ChatEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isGroupChat = null,
    Object? users = null,
    Object? groupAdmin = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isGroupChat: null == isGroupChat
          ? _value.isGroupChat
          : isGroupChat // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      groupAdmin: freezed == groupAdmin
          ? _value.groupAdmin
          : groupAdmin // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res>? get groupAdmin {
    if (_value.groupAdmin == null) {
      return null;
    }

    return $UserEntityCopyWith<$Res>(_value.groupAdmin!, (value) {
      return _then(_value.copyWith(groupAdmin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatEntityCopyWith<$Res>
    implements $ChatEntityCopyWith<$Res> {
  factory _$$_ChatEntityCopyWith(
          _$_ChatEntity value, $Res Function(_$_ChatEntity) then) =
      __$$_ChatEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      String name,
      @JsonKey(name: "is_group_chat") bool isGroupChat,
      @JsonKey(defaultValue: []) List<UserEntity> users,
      @JsonKey(name: "group_admin") UserEntity? groupAdmin,
      String createdAt,
      String updatedAt});

  @override
  $UserEntityCopyWith<$Res>? get groupAdmin;
}

/// @nodoc
class __$$_ChatEntityCopyWithImpl<$Res>
    extends _$ChatEntityCopyWithImpl<$Res, _$_ChatEntity>
    implements _$$_ChatEntityCopyWith<$Res> {
  __$$_ChatEntityCopyWithImpl(
      _$_ChatEntity _value, $Res Function(_$_ChatEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isGroupChat = null,
    Object? users = null,
    Object? groupAdmin = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_ChatEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isGroupChat: null == isGroupChat
          ? _value.isGroupChat
          : isGroupChat // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      groupAdmin: freezed == groupAdmin
          ? _value.groupAdmin
          : groupAdmin // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatEntity implements _ChatEntity {
  const _$_ChatEntity(
      {@JsonKey(name: "_id") required this.id,
      required this.name,
      @JsonKey(name: "is_group_chat") required this.isGroupChat,
      @JsonKey(defaultValue: []) final List<UserEntity> users = const [],
      @JsonKey(name: "group_admin") this.groupAdmin,
      required this.createdAt,
      required this.updatedAt})
      : _users = users;

  factory _$_ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$$_ChatEntityFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: "is_group_chat")
  final bool isGroupChat;
  final List<UserEntity> _users;
  @override
  @JsonKey(defaultValue: [])
  List<UserEntity> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey(name: "group_admin")
  final UserEntity? groupAdmin;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'ChatEntity(id: $id, name: $name, isGroupChat: $isGroupChat, users: $users, groupAdmin: $groupAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isGroupChat, isGroupChat) ||
                other.isGroupChat == isGroupChat) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.groupAdmin, groupAdmin) ||
                other.groupAdmin == groupAdmin) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      isGroupChat,
      const DeepCollectionEquality().hash(_users),
      groupAdmin,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatEntityCopyWith<_$_ChatEntity> get copyWith =>
      __$$_ChatEntityCopyWithImpl<_$_ChatEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatEntityToJson(
      this,
    );
  }
}

abstract class _ChatEntity implements ChatEntity {
  const factory _ChatEntity(
      {@JsonKey(name: "_id") required final String id,
      required final String name,
      @JsonKey(name: "is_group_chat") required final bool isGroupChat,
      @JsonKey(defaultValue: []) final List<UserEntity> users,
      @JsonKey(name: "group_admin") final UserEntity? groupAdmin,
      required final String createdAt,
      required final String updatedAt}) = _$_ChatEntity;

  factory _ChatEntity.fromJson(Map<String, dynamic> json) =
      _$_ChatEntity.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: "is_group_chat")
  bool get isGroupChat;
  @override
  @JsonKey(defaultValue: [])
  List<UserEntity> get users;
  @override
  @JsonKey(name: "group_admin")
  UserEntity? get groupAdmin;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ChatEntityCopyWith<_$_ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

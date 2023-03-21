// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_group_chat_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreateGroupChatRequest _$CreateGroupChatRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateGroupChatRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateGroupChatRequest {
  String get name => throw _privateConstructorUsedError;
  List<String> get users => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateGroupChatRequestCopyWith<CreateGroupChatRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateGroupChatRequestCopyWith<$Res> {
  factory $CreateGroupChatRequestCopyWith(CreateGroupChatRequest value,
          $Res Function(CreateGroupChatRequest) then) =
      _$CreateGroupChatRequestCopyWithImpl<$Res, CreateGroupChatRequest>;
  @useResult
  $Res call({String name, List<String> users});
}

/// @nodoc
class _$CreateGroupChatRequestCopyWithImpl<$Res,
        $Val extends CreateGroupChatRequest>
    implements $CreateGroupChatRequestCopyWith<$Res> {
  _$CreateGroupChatRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? users = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateGroupChatRequestCopyWith<$Res>
    implements $CreateGroupChatRequestCopyWith<$Res> {
  factory _$$_CreateGroupChatRequestCopyWith(_$_CreateGroupChatRequest value,
          $Res Function(_$_CreateGroupChatRequest) then) =
      __$$_CreateGroupChatRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> users});
}

/// @nodoc
class __$$_CreateGroupChatRequestCopyWithImpl<$Res>
    extends _$CreateGroupChatRequestCopyWithImpl<$Res,
        _$_CreateGroupChatRequest>
    implements _$$_CreateGroupChatRequestCopyWith<$Res> {
  __$$_CreateGroupChatRequestCopyWithImpl(_$_CreateGroupChatRequest _value,
      $Res Function(_$_CreateGroupChatRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? users = null,
  }) {
    return _then(_$_CreateGroupChatRequest(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreateGroupChatRequest implements _CreateGroupChatRequest {
  const _$_CreateGroupChatRequest(
      {required this.name, required final List<String> users})
      : _users = users;

  factory _$_CreateGroupChatRequest.fromJson(Map<String, dynamic> json) =>
      _$$_CreateGroupChatRequestFromJson(json);

  @override
  final String name;
  final List<String> _users;
  @override
  List<String> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'CreateGroupChatRequest(name: $name, users: $users)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateGroupChatRequest &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateGroupChatRequestCopyWith<_$_CreateGroupChatRequest> get copyWith =>
      __$$_CreateGroupChatRequestCopyWithImpl<_$_CreateGroupChatRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreateGroupChatRequestToJson(
      this,
    );
  }
}

abstract class _CreateGroupChatRequest implements CreateGroupChatRequest {
  const factory _CreateGroupChatRequest(
      {required final String name,
      required final List<String> users}) = _$_CreateGroupChatRequest;

  factory _CreateGroupChatRequest.fromJson(Map<String, dynamic> json) =
      _$_CreateGroupChatRequest.fromJson;

  @override
  String get name;
  @override
  List<String> get users;
  @override
  @JsonKey(ignore: true)
  _$$_CreateGroupChatRequestCopyWith<_$_CreateGroupChatRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

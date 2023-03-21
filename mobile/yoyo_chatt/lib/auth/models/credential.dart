import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.freezed.dart';
part 'credential.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const UserEntity._();
  const factory UserEntity({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
    @Default("") String avatar,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

@freezed
class Credential with _$Credential {
  const Credential._();

  const factory Credential({
    required UserEntity user,
    required String token,
  }) = _Credential;

  factory Credential.fromJson(Map<String, dynamic> json) =>
      _$CredentialFromJson(json);
}

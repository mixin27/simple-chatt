import 'package:yoyo_chatt/auth/models/credential.dart';

abstract class CredentialStorage {
  Future<Credential?> read();
  Future<void> save(Credential credential);
  Future<void> clear();
}

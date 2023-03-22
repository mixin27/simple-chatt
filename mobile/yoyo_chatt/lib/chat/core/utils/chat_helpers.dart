import 'package:yoyo_chatt/auth/models/credential.dart';

class ChatHelpers {
  static String getSender(UserEntity currentUser, List<UserEntity> chatUsers) {
    return chatUsers[0].id == currentUser.id
        ? chatUsers[1].name
        : chatUsers[0].name;
  }

  static UserEntity getSenderFull(
      UserEntity currentUser, List<UserEntity> chatUsers) {
    return chatUsers[0].id == currentUser.id ? chatUsers[1] : chatUsers[0];
  }
}

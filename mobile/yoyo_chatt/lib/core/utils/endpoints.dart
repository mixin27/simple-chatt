class Endpoints {
  static const _apiVersion = "/api";

  // Auth
  static const _baseAuth = "$_apiVersion/user";

  static const user = _baseAuth;
  static const register = _baseAuth;
  static const login = "$_baseAuth/login";
  static const logout = "$_baseAuth/logout";

  // Chat
  static const _baseChat = "$_apiVersion/chats";

  static const fetchingChats = _baseChat;
  static const createOrAccessChat = _baseChat;
  static const createGroupOrAccessChat = "$_baseChat/group";
  static const renameGroup = "$_baseChat/group/rename";
  static const addUserToGroup = "$_baseChat/group/adduser";
  static const removeUserFromGroup = "$_baseChat/group/removeuser";
}

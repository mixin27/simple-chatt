class Endpoints {
  static const _apiVersion = "/api";

  // Auth
  static const _baseAuth = "$_apiVersion/user";

  static const user = _baseAuth;
  static const register = "$_baseAuth/register";
  static const login = "$_baseAuth/login";
  static const logout = "$_baseAuth/logout";
}

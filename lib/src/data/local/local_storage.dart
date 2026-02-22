import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _tokenKey = 'access_token';
  static const _userKey = 'user';

  LocalStorage();

  Future<void> saveAccessToken(String token) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(_tokenKey, token);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(_tokenKey);
  }

  Future<void> deleteAccessToken() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove(_tokenKey);
  }

  Future<void> saveUser(String userJson) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(_userKey, userJson);
  }

  Future<String?> getUser() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(_userKey);
  }

  Future<void> deleteUser() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove(_userKey);
  }

  Future<void> clear() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove(_tokenKey);
    await storage.remove(_userKey);
  }
}

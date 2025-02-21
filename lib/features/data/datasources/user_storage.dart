import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  static final con = UserStorage();

  Future<String> getToken() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final fullToken = await secureStorage.read(key: 'token');
    return fullToken ?? "";
  }

  Future<bool> saveToken(String? token) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'token', value: token);

    return true;
  }

  void deleteToken() {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    secureStorage.delete(key: 'token');
  }
}

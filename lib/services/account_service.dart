import 'package:shared_preferences/shared_preferences.dart';

class AccountData {
  const AccountData({
    required this.username,
    required this.password,
    required this.isLoggedIn,
  });

  final String username;
  final String password;
  final bool isLoggedIn;
}

class AccountService {
  const AccountService._();

  static Future<AccountData> load() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('username')) {
      await preferences.setString('username', 'admin');
      await preferences.setString('password', 'admin');
    }

    return AccountData(
      username: preferences.getString('username') ?? 'admin',
      password: preferences.getString('password') ?? 'admin',
      isLoggedIn: preferences.getBool('isLoggedIn') ?? false,
    );
  }

  static Future<bool> login(String username, String password) async {
    final account = await load();
    if (username.trim() != account.username || password != account.password) {
      return false;
    }

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', true);
    return true;
  }

  static Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', false);
  }

  static Future<void> update({
    required String username,
    required String password,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', username.trim());
    await preferences.setString('password', password);
  }
}

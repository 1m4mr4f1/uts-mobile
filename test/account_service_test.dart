import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_ppb/services/account_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('initializes the default account and checks login state', () async {
    final account = await AccountService.load();

    expect(account.username, 'admin');
    expect(account.password, 'admin');
    expect(account.isLoggedIn, isFalse);

    expect(await AccountService.login('wrong', 'admin'), isFalse);
    expect(await AccountService.login('admin', 'wrong'), isFalse);
    expect(await AccountService.login(' admin ', 'admin'), isTrue);
    expect((await AccountService.load()).isLoggedIn, isTrue);

    await AccountService.logout();
    expect((await AccountService.load()).isLoggedIn, isFalse);
  });

  test('updates username and password for subsequent logins', () async {
    await AccountService.load();
    await AccountService.update(username: '  kasir  ', password: 'rahasia');

    final account = await AccountService.load();
    expect(account.username, 'kasir');
    expect(account.password, 'rahasia');
    expect(await AccountService.login('admin', 'admin'), isFalse);
    expect(await AccountService.login('kasir', 'rahasia'), isTrue);
  });
}

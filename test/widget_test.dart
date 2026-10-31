import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_ppb/main.dart';

Future<void> _openDashboard(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(const WarungAjibApp());
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();

  await tester.enterText(find.byKey(const Key('usernameField')), 'admin');
  await tester.enterText(find.byKey(const Key('passwordField')), 'admin');
  await tester.tap(find.text('Masuk'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('login, tambah produk, dan selesaikan pembayaran', (
    tester,
  ) async {
    await _openDashboard(tester);
    expect(find.text('Daftar Produk'), findsOneWidget);

    await tester.tap(find.byTooltip('Tambah Es Teh Ajib'));
    await tester.pumpAndSettle();
    expect(find.text('Rp 5.000'), findsWidgets);

    await tester.tap(find.text('Bayar'));
    await tester.pumpAndSettle();
    expect(find.text('Jumlah Pembayaran'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('paymentField')), '4000');
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Selesaikan'))
          .onPressed,
      isNull,
    );
    expect(find.text('Pembayaran masih kurang.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('paymentField')), '10000');
    await tester.pump();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Selesaikan'))
          .onPressed,
      isNotNull,
    );
    await tester.ensureVisible(find.text('Selesaikan'));
    await tester.tap(find.text('Selesaikan'));
    await tester.pumpAndSettle();

    expect(find.text('Pembayaran'), findsNothing);
    expect(find.text('Transaksi berhasil. Kembalian Rp 5.000'), findsOneWidget);
    expect(find.text('Total Penjualan • 0 item'), findsOneWidget);
  });

  testWidgets('detail produk tampil dan tambah hanya dari tombol plus', (
    tester,
  ) async {
    await _openDashboard(tester);

    await tester.tap(
      find
          .text('Lumpia renyah dengan isian gurih, cocok untuk teman santai.')
          .first,
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('productDetailImage')), findsOneWidget);
    expect(
      find.textContaining('Lumpia renyah dengan isian gurih'),
      findsWidgets,
    );
    expect(find.text('Total Penjualan • 0 item'), findsOneWidget);

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('productImage_Lumpia')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('productDetailImage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('addProductFromDetails')));
    await tester.pumpAndSettle();

    expect(find.text('Total Penjualan • 1 item'), findsOneWidget);
    expect(find.text('Rp 3.000'), findsWidgets);
  });

  testWidgets('keranjang dapat menambah, mengurangi, dan menghapus produk', (
    tester,
  ) async {
    await _openDashboard(tester);

    await tester.tap(find.byTooltip('Tambah Es Teh Ajib'));
    await tester.tap(find.byTooltip('Tambah Lumpia'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('cartButton')));
    await tester.pumpAndSettle();

    expect(find.text('Keranjang Penjualan'), findsOneWidget);
    expect(find.text('Es Teh Ajib'), findsWidgets);
    expect(find.text('Lumpia'), findsWidgets);
    expect(find.text('Total: Rp 8.000'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('increase_Es Teh Ajib')));
    await tester.pumpAndSettle();
    expect(find.text('Total: Rp 13.000'), findsOneWidget);
    expect(find.text('Total Penjualan • 3 item'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('decrease_Es Teh Ajib')));
    await tester.pumpAndSettle();
    expect(find.text('Total: Rp 8.000'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('remove_Lumpia')));
    await tester.pumpAndSettle();
    expect(find.text('Lumpia'), findsOneWidget);
    expect(find.text('Total: Rp 5.000'), findsOneWidget);
    expect(find.text('Total Penjualan • 1 item'), findsOneWidget);

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.text('Rp 5.000'), findsWidgets);
  });
}

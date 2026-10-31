import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/brand_mark.dart';
import '../widgets/cart_dialog.dart';
import '../widgets/product_card.dart';
import '../widgets/product_details_dialog.dart';
import '../widgets/sales_summary.dart';
import 'payment_screen.dart';
import 'update_account_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.username,
    required this.onLogout,
  });

  final String username;
  final Future<void> Function() onLogout;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const _sellerPhoneNumber = '089659535129';

  final Map<String, int> _cart = {};
  late String _username;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
  }

  int get _totalItems => _cart.values.fold(0, (total, count) => total + count);

  int get _totalPrice => productCatalog.fold(
    0,
    (total, product) => total + product.price * (_cart[product.name] ?? 0),
  );

  void _addProduct(Product product) {
    setState(
      () => _cart.update(product.name, (count) => count + 1, ifAbsent: () => 1),
    );
  }

  void _showCart() {
    showDialog<void>(
      context: context,
      builder: (context) => CartDialog(
        cart: _cart,
        onCartChanged: (cart) {
          setState(() {
            _cart
              ..clear()
              ..addAll(cart);
          });
        },
      ),
    );
  }

  void _showProductDetails(Product product) {
    showDialog<void>(
      context: context,
      builder: (context) => ProductDetailsDialog(
        product: product,
        onAdd: () {
          Navigator.pop(context);
          _addProduct(product);
        },
      ),
    );
  }

  Future<void> _contactSeller({required bool sms}) async {
    final uri = Uri(
      scheme: sms ? 'sms' : 'tel',
      path: _sellerPhoneNumber,
      queryParameters: sms
          ? {'body': 'Halo Warung Ajib, saya ingin bertanya.'}
          : null,
    );
    await _openExternal(uri, sms ? 'SMS' : 'telepon');
  }

  Future<void> _openMaps() async {
    final uri = Uri.parse('https://maps.app.goo.gl/Mz24fkJB51dQ54qA7');
    await _openExternal(uri, 'peta');
  }

  Future<void> _openExternal(Uri uri, String label) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        mounted) {
      _notify('Aplikasi untuk membuka $label tidak ditemukan.');
    }
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showAccountMenu(String choice) {
    switch (choice) {
      case 'call':
        _contactSeller(sms: false);
        break;
      case 'sms':
        _contactSeller(sms: true);
        break;
      case 'maps':
        _openMaps();
        break;
      case 'account':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => UpdateAccountScreen(
              onUpdated: (username) {
                if (!mounted) return;
                setState(() => _username = username);
                _notify('Username dan password berhasil diperbarui.');
              },
            ),
          ),
        );
        break;
      case 'logout':
        widget.onLogout();
        break;
    }
  }

  Future<void> _checkout() async {
    if (_totalPrice == 0) return;
    final total = _totalPrice;
    final paid = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(builder: (context) => PaymentScreen(total: total)),
    );
    if (paid == null || !mounted) return;
    setState(_cart.clear);
    _notify('Transaksi berhasil. Kembalian ${formatRupiah(paid - total)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppLayout.gutter(context),
        actionsPadding: EdgeInsets.only(right: AppLayout.gutter(context) - 8),
        title: Row(
          children: [
            const BrandMark(size: 40),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Warung Ajib',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Bandungrejo, Demak',
                  style: TextStyle(fontSize: 12, color: AppColors.muted),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Menu',
            onSelected: _showAccountMenu,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'call',
                child: ListTile(
                  leading: Icon(Icons.call_outlined),
                  title: Text('Call Center'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'sms',
                child: ListTile(
                  leading: Icon(Icons.sms_outlined),
                  title: Text('SMS Center'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'maps',
                child: ListTile(
                  leading: Icon(Icons.map_outlined),
                  title: Text('Lokasi / Maps'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'account',
                child: ListTile(
                  leading: Icon(Icons.manage_accounts_outlined),
                  title: Text('Update User & Password'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text('Keluar'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  AppLayout.gutter(context),
                  20,
                  AppLayout.gutter(context),
                  20,
                ),
                children: [
                  Text(
                    'Hai, $_username',
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mau jual apa hari ini?',
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.orangeTint,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.orangeLine),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Produk UMKM pilihan',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Segar, enak, dan dibuat dengan hati.',
                          style: TextStyle(color: AppColors.ink, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Expanded(
                        child: Text(
                          'Daftar Produk',
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        '${productCatalog.length} menu',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...productCatalog.map(
                    (product) => ProductCard(
                      product: product,
                      quantity: _cart[product.name] ?? 0,
                      onProductTap: () => _showProductDetails(product),
                      onAddTap: () => _addProduct(product),
                    ),
                  ),
                ],
              ),
            ),
            SalesSummary(
              itemCount: _totalItems,
              total: _totalPrice,
              onTap: _totalPrice == 0 ? null : _checkout,
              onCartTap: _showCart,
            ),
          ],
        ),
      ),
    );
  }
}

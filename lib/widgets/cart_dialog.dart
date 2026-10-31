import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'product_image.dart';

class CartDialog extends StatefulWidget {
  const CartDialog({
    super.key,
    required this.cart,
    required this.onCartChanged,
  });

  final Map<String, int> cart;
  final ValueChanged<Map<String, int>> onCartChanged;

  @override
  State<CartDialog> createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {
  late final Map<String, int> _cart = Map<String, int>.of(widget.cart);

  int get _total => productCatalog.fold(
    0,
    (total, product) => total + product.price * (_cart[product.name] ?? 0),
  );

  void _updateQuantity(Product product, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _cart.remove(product.name);
      } else {
        _cart[product.name] = quantity;
      }
    });
    widget.onCartChanged(Map<String, int>.of(_cart));
  }

  @override
  Widget build(BuildContext context) {
    final products = productCatalog
        .where((product) => (_cart[product.name] ?? 0) > 0)
        .toList();

    return AlertDialog(
      title: const Text('Keranjang Penjualan'),
      content: SizedBox(
        width: 400,
        child: products.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Keranjang masih kosong.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.muted),
                ),
              )
            : ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 420),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: products.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 20),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final quantity = _cart[product.name]!;
                    return Row(
                      children: [
                        ProductImage(
                          key: ValueKey('cartImage_${product.name}'),
                          product: product,
                          width: 48,
                          height: 48,
                          emojiSize: 26,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.ink,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${formatRupiah(product.price)} × $quantity',
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          key: ValueKey('decrease_${product.name}'),
                          tooltip: 'Kurangi ${product.name}',
                          visualDensity: VisualDensity.compact,
                          onPressed: () =>
                              _updateQuantity(product, quantity - 1),
                          icon: const Icon(Icons.remove_rounded),
                        ),
                        Text(
                          '$quantity',
                          key: ValueKey('quantity_${product.name}'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFeatures: tabularFigures,
                          ),
                        ),
                        IconButton(
                          key: ValueKey('increase_${product.name}'),
                          tooltip: 'Tambah ${product.name}',
                          visualDensity: VisualDensity.compact,
                          onPressed: () =>
                              _updateQuantity(product, quantity + 1),
                          icon: const Icon(Icons.add_rounded),
                        ),
                        IconButton(
                          key: ValueKey('remove_${product.name}'),
                          tooltip: 'Hapus ${product.name}',
                          visualDensity: VisualDensity.compact,
                          onPressed: () => _updateQuantity(product, 0),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.danger,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
      ),
      actions: [
        Text(
          'Total: ${formatRupiah(_total)}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.orange,
            fontFeatures: tabularFigures,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}

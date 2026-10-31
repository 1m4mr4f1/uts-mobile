import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'product_image.dart';

class ProductDetailsDialog extends StatelessWidget {
  const ProductDetailsDialog({
    super.key,
    required this.product,
    required this.onAdd,
  });

  final Product product;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              key: const Key('productDetailImage'),
              product: product,
              width: double.infinity,
              height: 190,
              emojiSize: 88,
            ),
            const SizedBox(height: 18),
            Text(
              product.name,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(color: AppColors.muted, height: 1.4),
            ),
            const SizedBox(height: 14),
            Text(
              formatRupiah(product.price),
              style: const TextStyle(
                color: AppColors.orange,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFeatures: tabularFigures,
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
        FilledButton.icon(
          key: const Key('addProductFromDetails'),
          onPressed: onAdd,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Tambah ke Keranjang'),
        ),
      ],
    );
  }
}

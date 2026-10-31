import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    required this.width,
    required this.height,
    this.emojiSize = 38,
  });

  final Product product;
  final double width;
  final double height;
  final double emojiSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: product.color,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        product.imageAsset,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Text(product.emoji, style: TextStyle(fontSize: emojiSize)),
        ),
      ),
    );
  }
}

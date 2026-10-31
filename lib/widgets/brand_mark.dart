import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, required this.size, this.light = false});

  final double size;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: light ? Colors.white : AppColors.orangeTint,
        borderRadius: BorderRadius.circular(size * .25),
        border: light ? null : Border.all(color: AppColors.orangeLine),
      ),
      child: Icon(
        Icons.storefront_rounded,
        size: size * .55,
        color: AppColors.orange,
      ),
    );
  }
}

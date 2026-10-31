import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/formatters.dart';

class SalesSummary extends StatelessWidget {
  const SalesSummary({
    super.key,
    required this.itemCount,
    required this.total,
    required this.onTap,
    required this.onCartTap,
  });

  final int itemCount;
  final int total;
  final VoidCallback? onTap;
  final VoidCallback onCartTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const Border(top: BorderSide(color: AppColors.line)),
      child: SafeArea(
        top: false,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.gutter(context),
              vertical: 12,
            ),
            child: Row(
              children: [
                Tooltip(
                  message: 'Lihat keranjang',
                  child: Material(
                    color: AppColors.orangeTint,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      side: const BorderSide(color: AppColors.orangeLine),
                    ),
                    child: InkWell(
                      key: const Key('cartButton'),
                      onTap: onCartTap,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: const SizedBox(
                        height: 48,
                        width: 48,
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Penjualan • $itemCount item',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatRupiah(total),
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFeatures: tabularFigures,
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: onTap,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Bayar'),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

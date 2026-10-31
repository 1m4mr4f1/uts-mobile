import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/field_label.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.total});

  final int total;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _paymentController = TextEditingController();
  int get _paid => int.tryParse(_paymentController.text) ?? 0;
  int get _change => _paid - widget.total;

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppLayout.gutter(context),
            vertical: 20,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Transaksi',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(widget.total),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      fontFeatures: tabularFigures,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const FieldLabel('Jumlah Pembayaran'),
            const SizedBox(height: 8),
            TextField(
              key: const Key('paymentField'),
              controller: _paymentController,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                prefixText: 'Rp ',
                hintText: 'Masukkan uang dari pelanggan',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.orangeTint,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.orangeLine),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.currency_exchange_rounded,
                    color: AppColors.orange,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Kembalian',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  Text(
                    formatRupiah(_change > 0 ? _change : 0),
                    style: const TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      fontFeatures: tabularFigures,
                    ),
                  ),
                ],
              ),
            ),
            if (_paid > 0 && _paid < widget.total) ...[
              const SizedBox(height: 12),
              const Text(
                'Pembayaran masih kurang.',
                style: TextStyle(color: AppColors.danger, fontSize: 13),
              ),
            ],
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _paid >= widget.total && _paid > 0
                        ? () => Navigator.pop(context, _paid)
                        : null,
                    child: const Text('Selesaikan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

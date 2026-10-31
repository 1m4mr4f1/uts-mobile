import 'package:flutter_test/flutter_test.dart';
import 'package:uts_ppb/utils/formatters.dart';

void main() {
  test('formats Rupiah values with Indonesian thousands separators', () {
    expect(formatRupiah(0), 'Rp 0');
    expect(formatRupiah(999), 'Rp 999');
    expect(formatRupiah(5000), 'Rp 5.000');
    expect(formatRupiah(123456789), 'Rp 123.456.789');
  });
}

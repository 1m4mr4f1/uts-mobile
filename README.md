# uts-mobile

Aplikasi Flutter sederhana untuk membantu penjualan produk UMKM Warung Ajib.

## Fitur

- Splash screen dan login dengan data akun yang disimpan di `SharedPreferences`.
- Dashboard berisi daftar produk dan harga contoh.
- Ketuk nama produk untuk melihat deskripsinya; ketuk gambar atau tombol tambah
  untuk memasukkannya ke penjualan.
- Ringkasan penjualan membuka pembayaran dan menghitung kembalian.
- Menu Call Center, SMS Center, Maps, ubah akun, dan keluar.

## Menjalankan aplikasi

```shell
flutter pub get
flutter run
```

Login pertama kali menggunakan `admin` untuk username dan password. Ubah akun
melalui menu **Update User & Password**.

## Struktur kode

- `lib/main.dart`: titik masuk aplikasi.
- `lib/app.dart`: tema Material dan alur sesi aplikasi.
- `lib/screens/`: splash screen, login, dashboard, pembayaran, dan pembaruan
  akun.
- `lib/widgets/`: widget yang digunakan ulang, seperti kartu produk dan ringkasan
  penjualan.
- `lib/models/product.dart`: model serta katalog produk contoh.
- `lib/services/account_service.dart`: penyimpanan dan validasi akun.
- `lib/theme/` dan `lib/utils/`: warna aplikasi dan format Rupiah.

Produk contoh dapat disesuaikan pada `lib/models/product.dart`. Call Center dan
SMS Center meminta nomor penjual saat dipilih. Maps membuka pencarian Google
Maps untuk Warung Ajib, Bandungrejo, Mranggen, Demak.

Jalankan pengujian dengan `flutter test`.

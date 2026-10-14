/// Nama rute = kunci layar di prototype Figma.
class R {
  // Publik & Akun
  static const beranda = '/';
  static const masuk = '/masuk';
  static const daftar = '/daftar';
  static const harga = '/harga';
  static const cari = '/cari';
  static const detail = '/detail';

  // Warga (entitas kunci)
  static const wDash = '/warga';
  static const a1 = '/warga/ajukan-1';
  static const a2 = '/warga/ajukan-2';
  static const a3 = '/warga/ajukan-3';
  static const wRinci = '/warga/rincian';
  static const dampak = '/warga/dampak';
  static const wProfil = '/warga/profil';
  static const wProfilEdit = '/warga/profil/edit';
  static const wAlamat = '/warga/alamat';

  // Transaksi (permintaan penjemputan)
  static const wPermintaan = '/warga/permintaan';
  static const wPermintaanDetail = '/warga/permintaan/detail';
  static const wPermintaanEdit = '/warga/permintaan/edit';

  // Pengepul (entitas target)
  static const pDash = '/pengepul';
  static const pMasuk = '/pengepul/masuk';
  static const timbang = '/pengepul/timbang';
  static const terbuka = '/pengepul/terbuka';
  static const dompet = '/pengepul/dompet';
  static const pMenu = '/pengepul/menu';
  static const lapak = '/pengepul/lapak';
  static const lapakEdit = '/pengepul/lapak/edit';
  static const hargaBeli = '/pengepul/harga-beli';

  // Admin (entitas pengelola)
  static const adDash = '/admin';
  static const verif = '/admin/verifikasi';
  static const topup = '/admin/topup';
  static const sengketa = '/admin/sengketa';
  static const adMenu = '/admin/menu';
  static const adHarga = '/admin/harga';
  static const adHargaForm = '/admin/harga/form';
}

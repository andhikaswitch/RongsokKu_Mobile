import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';
import 'screens/publik/beranda.dart';
import 'screens/publik/masuk.dart';
import 'screens/publik/daftar.dart';
import 'screens/publik/harga.dart';
import 'screens/publik/cari.dart';
import 'screens/publik/detail.dart';
import 'screens/warga/dashboard.dart';
import 'screens/warga/ajukan.dart';
import 'screens/warga/rincian.dart';
import 'screens/warga/dampak.dart';
import 'screens/warga/profil.dart';
import 'screens/warga/permintaan.dart';
import 'screens/pengepul/dashboard.dart';
import 'screens/pengepul/masuk.dart';
import 'screens/pengepul/terbuka.dart';
import 'screens/pengepul/timbang.dart';
import 'screens/pengepul/dompet.dart';
import 'screens/pengepul/menu.dart';
import 'screens/pengepul/lapak.dart';
import 'screens/admin/dashboard.dart';
import 'screens/admin/verifikasi.dart';
import 'screens/admin/sengketa.dart';
import 'screens/admin/topup.dart';
import 'screens/admin/menu.dart';
import 'screens/admin/harga.dart';

void main() {
  runApp(const RongsokKuApp());
}

class RongsokKuApp extends StatelessWidget {
  const RongsokKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RongsokKu',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: R.beranda,
      routes: {
        R.beranda: (_) => const BerandaScreen(),
        R.masuk: (_) => const MasukScreen(),
        R.daftar: (_) => const DaftarScreen(),
        R.harga: (_) => const HargaScreen(),
        R.cari: (_) => const CariScreen(),
        R.detail: (_) => const DetailScreen(),
        R.wDash: (_) => const WargaDashboard(),
        R.a1: (_) => const Ajukan1Screen(),
        R.a2: (_) => const Ajukan2Screen(),
        R.a3: (_) => const Ajukan3Screen(),
        R.wRinci: (_) => const RincianScreen(),
        R.dampak: (_) => const DampakScreen(),
        R.wProfil: (_) => const ProfilScreen(),
        R.wProfilEdit: (_) => const EditProfilScreen(),
        R.wAlamat: (_) => const AlamatFormScreen(),
        R.wPermintaan: (_) => const PermintaanListScreen(),
        R.wPermintaanDetail: (_) => const PermintaanDetailScreen(),
        R.wPermintaanEdit: (_) => const PermintaanEditScreen(),
        R.pDash: (_) => const PengepulDashboard(),
        R.pMasuk: (_) => const PengepulMasuk(),
        R.terbuka: (_) => const TerbukaScreen(),
        R.timbang: (_) => const TimbangScreen(),
        R.dompet: (_) => const DompetScreen(),
        R.pMenu: (_) => const PengepulMenuScreen(),
        R.lapak: (_) => const LapakScreen(),
        R.lapakEdit: (_) => const EditLapakScreen(),
        R.hargaBeli: (_) => const HargaBeliFormScreen(),
        R.adDash: (_) => const AdminDashboard(),
        R.verif: (_) => const VerifikasiScreen(),
        R.sengketa: (_) => const SengketaScreen(),
        R.topup: (_) => const TopupScreen(),
        R.adMenu: (_) => const AdminMenuScreen(),
        R.adHarga: (_) => const KelolaHargaScreen(),
        R.adHargaForm: (_) => const JenisFormScreen(),
      },
    );
  }
}

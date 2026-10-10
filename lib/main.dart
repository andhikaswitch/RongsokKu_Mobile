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
import 'screens/pengepul/dashboard.dart';
import 'screens/pengepul/masuk.dart';
import 'screens/pengepul/terbuka.dart';
import 'screens/pengepul/timbang.dart';
import 'screens/pengepul/dompet.dart';
import 'screens/admin/dashboard.dart';
import 'screens/admin/verifikasi.dart';
import 'screens/admin/sengketa.dart';
import 'screens/admin/topup.dart';

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
        R.pDash: (_) => const PengepulDashboard(),
        R.pMasuk: (_) => const PengepulMasuk(),
        R.terbuka: (_) => const TerbukaScreen(),
        R.timbang: (_) => const TimbangScreen(),
        R.dompet: (_) => const DompetScreen(),
        R.adDash: (_) => const AdminDashboard(),
        R.verif: (_) => const VerifikasiScreen(),
        R.sengketa: (_) => const SengketaScreen(),
        R.topup: (_) => const TopupScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

/// Tab "Lainnya" Pengepul: profil lapak, harga beli, dompet.
class PengepulMenuScreen extends StatelessWidget {
  const PengepulMenuScreen({super.key});

  Future<void> _keluar(BuildContext context) async {
    final ok = await confirmDialog(context,
        title: 'Keluar dari akun?',
        message: 'Kamu tidak akan menerima notifikasi permintaan baru '
            'sampai masuk lagi.',
        confirm: 'Keluar',
        icon: LucideIcons.logOut);
    if (ok && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, R.beranda, (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Lainnya', 'Lapak Hijau Karawang', notif: false),
      bottomNavigationBar: pengepulNav(context, 4),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            onTap: () => Navigator.pushNamed(context, R.lapak),
            child: Row(
              children: [
                const InitialAvatar('HK', size: 52),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lapak Hijau Karawang', style: T.m),
                      const SizedBox(height: 4),
                      const VerifiedBadge(showText: true),
                    ],
                  ),
                ),
                const Icon(LucideIcons.chevronRight,
                    size: 18, color: AppColors.slate400),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Kelola Lapak'),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                MenuTile(
                  icon: LucideIcons.store,
                  title: 'Profil Lapak',
                  subtitle: 'Alamat, jam buka, jenis diterima',
                  tag: 'CRUD',
                  onTap: () => Navigator.pushNamed(context, R.lapak),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.tags,
                  title: 'Harga Beli per kg',
                  subtitle: 'Tambah, ubah, hapus harga beli',
                  tag: 'CRUD',
                  onTap: () => Navigator.pushNamed(context, R.lapak),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.wallet,
                  title: 'Dompet & Saldo',
                  subtitle: 'Saldo Rp 148.500',
                  onTap: () => Navigator.pushNamed(context, R.dompet),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.chartLine,
                  title: 'Pusat Harga',
                  subtitle: 'Indeks harga pasar',
                  onTap: () => Navigator.pushNamed(context, R.harga),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            padding: EdgeInsets.zero,
            child: MenuTile(
              icon: LucideIcons.logOut,
              title: 'Keluar',
              danger: true,
              onTap: () => _keluar(context),
            ),
          ),
        ],
      ),
    );
  }
}

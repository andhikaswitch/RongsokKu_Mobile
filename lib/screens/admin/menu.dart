import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

/// Tab "Lainnya" Admin: pintu masuk ke pengelolaan master data.
class AdminMenuScreen extends StatelessWidget {
  const AdminMenuScreen({super.key});

  Future<void> _keluar(BuildContext context) async {
    final ok = await confirmDialog(context,
        title: 'Keluar dari akun admin?',
        message: 'Kamu perlu masuk lagi untuk mengelola platform.',
        confirm: 'Keluar',
        icon: LucideIcons.logOut);
    if (ok && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, R.beranda, (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Lainnya', 'Pengelolaan platform', notif: false),
      bottomNavigationBar: adminNav(context, 4),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Row(
              children: [
                const InitialAvatar('AD',
                    size: 48,
                    circle: true,
                    bg: AppColors.slate900,
                    fg: AppColors.putih),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Admin RongsokKu', style: T.m),
                      Text('admin@rongsokku.test', style: T.s),
                    ],
                  ),
                ),
                const Pill('Pengelola',
                    bg: AppColors.merk50, fg: AppColors.merk700, fontSize: 10),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Master Data'),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                MenuTile(
                  icon: LucideIcons.tags,
                  title: 'Jenis & Harga Rongsok',
                  subtitle: 'Tambah, ubah, hapus harga acuan',
                  tag: 'CRUD',
                  onTap: () => Navigator.pushNamed(context, R.adHarga),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Moderasi'),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                MenuTile(
                  icon: LucideIcons.shieldCheck,
                  title: 'Verifikasi Pengepul',
                  subtitle: '1 lapak menunggu',
                  onTap: () => Navigator.pushNamed(context, R.verif),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.wallet,
                  title: 'Verifikasi Top-up',
                  subtitle: 'Bukti transfer pengepul',
                  onTap: () => goTab(context, R.topup, R.adDash),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.triangleAlert,
                  title: 'Sengketa',
                  subtitle: '1 sengketa terbuka',
                  onTap: () => Navigator.pushNamed(context, R.sengketa),
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

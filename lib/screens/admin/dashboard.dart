import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: adminNav(context, 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Panel Admin',
                        style:
                            TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                    Text('RongsokKu • Cikampek',
                        style:
                            TextStyle(color: AppColors.inkMuted, fontSize: 13)),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.emeraldLight,
                  child: Text('🛡', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: _Stat('1.284', 'Warga', AppColors.emerald)),
                SizedBox(width: 12),
                Expanded(child: _Stat('86', 'Pengepul', AppColors.amber)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: _Stat('3.9 ton', 'Daur ulang', Color(0xFF0284C7))),
                SizedBox(width: 12),
                Expanded(child: _Stat('Rp 54 jt', 'Transaksi', Color(0xFF7C3AED))),
              ],
            ),
            const SizedBox(height: 24),
            const SectionHeader('Antrean tugas'),
            const SizedBox(height: 12),
            _AntreanItem(
              icon: Icons.verified_outlined,
              bg: AppColors.emeraldLight,
              fg: AppColors.emerald,
              title: 'Verifikasi pengepul',
              sub: '3 menunggu peninjauan',
              onTap: () => Navigator.pushNamed(context, R.verif),
            ),
            _AntreanItem(
              icon: Icons.account_balance_wallet_outlined,
              bg: AppColors.amberLight,
              fg: AppColors.amber,
              title: 'Verifikasi top-up',
              sub: '5 menunggu konfirmasi',
              onTap: () => Navigator.pushNamed(context, R.verif),
            ),
            _AntreanItem(
              icon: Icons.gavel_outlined,
              bg: const Color(0xFFFEE2E2),
              fg: AppColors.danger,
              title: 'Sengketa terbuka',
              sub: '2 perlu diputuskan',
              onTap: () => Navigator.pushNamed(context, R.sengketa),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _Stat(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: color)),
          Text(label,
              style: const TextStyle(color: AppColors.inkMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

class _AntreanItem extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  final String title;
  final String sub;
  final VoidCallback onTap;
  const _AntreanItem({
    required this.icon,
    required this.bg,
    required this.fg,
    required this.title,
    required this.sub,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration:
                  BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: fg),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(sub,
                      style: const TextStyle(
                          color: AppColors.inkMuted, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.inkMuted),
          ],
        ),
      ),
    );
  }
}

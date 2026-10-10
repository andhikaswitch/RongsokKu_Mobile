import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Dashboard Admin', 'Ringkasan platform'),
      bottomNavigationBar: adminNav(context, 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu pendapatan
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.slate900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Pendapatan komisi · 30 hari',
                          style: T.s.copyWith(color: AppColors.slate400)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.merk600,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.trendingUp,
                              size: 12, color: AppColors.merk50),
                          const SizedBox(width: 4),
                          Text('+12%',
                              style: T.xs.copyWith(color: AppColors.merk50)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Rp 1.284.650',
                    style: T.xl.copyWith(color: AppColors.putih)),
                const SizedBox(height: 12),
                const Sparkline(
                  points: [3, 4, 3.6, 4.4, 4.1, 5, 4.6, 5.4, 5.1, 6, 5.7, 6.6],
                  color: AppColors.merk500,
                  height: 40,
                  fill: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _Stat(LucideIcons.truck, '420', 'Transaksi selesai',
                    AppColors.merk50, AppColors.merk700),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _Stat(LucideIcons.users, '86', 'Pengguna aktif',
                    AppColors.sky50, AppColors.sky700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SectionHeader('Antrean Tindakan'),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _Antrean(
                  icon: LucideIcons.shieldCheck,
                  bg: AppColors.nilai50,
                  fg: AppColors.nilai700,
                  title: 'Verifikasi pengepul',
                  subtitle: 'Rongsok Maju Bersama menunggu',
                  onTap: () => Navigator.pushNamed(context, R.verif),
                ),
                const Sep(),
                _Antrean(
                  icon: LucideIcons.wallet,
                  bg: AppColors.sky50,
                  fg: AppColors.sky700,
                  title: 'Verifikasi top-up',
                  subtitle: 'Rp 200.000 · bukti transfer',
                  onTap: () => goTab(context, R.topup, R.adDash),
                ),
                const Sep(),
                _Antrean(
                  icon: LucideIcons.triangleAlert,
                  bg: AppColors.rose50,
                  fg: AppColors.rose600,
                  title: 'Sengketa terbuka',
                  subtitle: 'SKT-00001 · harga diturunkan',
                  onTap: () => Navigator.pushNamed(context, R.sengketa),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Pengepul Perlu Diawasi'),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const InitialAvatar('RB',
                        size: 40, bg: AppColors.rose50, fg: AppColors.rose700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rongsok Berkah', style: T.bodyBold),
                          Text('Kepatuhan harga 71% · 3 label penyimpangan',
                              style: T.s.copyWith(color: AppColors.rose600)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: const LinearProgressIndicator(
                    value: 0.71,
                    minHeight: 6,
                    backgroundColor: AppColors.slate100,
                    valueColor: AlwaysStoppedAnimation(AppColors.rose600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color bg;
  final Color fg;
  const _Stat(this.icon, this.value, this.label, this.bg, this.fg);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBox(icon, bg: bg, fg: fg),
          const SizedBox(height: 8),
          Text(value, style: T.l),
          const SizedBox(height: 2),
          Text(label, style: T.s),
        ],
      ),
    );
  }
}

class _Antrean extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _Antrean({
    required this.icon,
    required this.bg,
    required this.fg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            IconBox(icon, size: 36, bg: bg, fg: fg),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: T.bodyBold),
                  Text(subtitle, style: T.s),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.rose600, shape: BoxShape.circle),
              child: Text('1', style: T.xs.copyWith(color: AppColors.putih)),
            ),
            const SizedBox(width: 6),
            const Icon(LucideIcons.chevronRight,
                size: 18, color: AppColors.slate400),
          ],
        ),
      ),
    );
  }
}

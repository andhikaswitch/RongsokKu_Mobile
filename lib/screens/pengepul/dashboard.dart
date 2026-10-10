import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class PengepulDashboard extends StatelessWidget {
  const PengepulDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Dashboard', 'Lapak Hijau Karawang'),
      bottomNavigationBar: pengepulNav(context, 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu saldo deposit
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
                    const Icon(LucideIcons.wallet,
                        size: 16, color: AppColors.slate400),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text('Saldo deposit',
                          style: T.s.copyWith(color: AppColors.slate400)),
                    ),
                    Pill('Aktif menerima',
                        bg: AppColors.merk600,
                        fg: AppColors.merk50,
                        fontSize: 10),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Rp 148.500', style: T.xl.copyWith(color: AppColors.putih)),
                const SizedBox(height: 6),
                Text(
                  'Minimum Rp 50.000 · komisi 5% dipotong saat transaksi selesai',
                  style: T.s.copyWith(color: AppColors.slate400),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton.amber(
                        label: 'Isi Saldo',
                        onTap: () => Navigator.pushNamed(context, R.dompet),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Riwayat',
                        color: AppColors.merk50,
                        fg: AppColors.merk800,
                        onTap: () => Navigator.pushNamed(context, R.dompet),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: _StatCard(
                    icon: LucideIcons.chartLine,
                    value: 'Rp 2,46 jt',
                    label: 'Omzet 14 hari'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                    icon: LucideIcons.scale,
                    value: '842 kg',
                    label: 'Ditimbang 14 hari',
                    amber: true),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionHeader('Permintaan Masuk',
              action: '3 baru',
              onAction: () => goTab(context, R.pMasuk, R.pDash)),
          const SizedBox(height: 12),
          RequestCard(
            code: 'RSK-00133',
            status: 'Menunggu Respons',
            tone: Tone.orange,
            title: 'Siti Aminah · 0,8 km',
            schedule: 'Sab, 4 Okt · 09.00–11.00',
            summary: '3 jenis · ±18 kg',
            amount: '± Rp 42.600',
            onTap: () => Navigator.pushNamed(context, R.timbang),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: OutlineButton(label: 'Tolak', onTap: () {})),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  label: 'Terima & Jadwalkan',
                  onTap: () => Navigator.pushNamed(context, R.timbang),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool amber;
  const _StatCard(
      {required this.icon,
      required this.value,
      required this.label,
      this.amber = false});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBox(icon,
              bg: amber ? AppColors.nilai50 : AppColors.merk50,
              fg: amber ? AppColors.nilai700 : AppColors.merk700),
          const SizedBox(height: 8),
          Text(value, style: T.l),
          const SizedBox(height: 2),
          Text(label, style: T.s),
        ],
      ),
    );
  }
}

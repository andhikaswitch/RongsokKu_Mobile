import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class WargaDashboard extends StatelessWidget {
  const WargaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Dashboard', 'Halo, Siti Aminah 👋'),
      bottomNavigationBar: wargaNav(context, 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu sapaan
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.merk700, Color(0xFF069669)],
                stops: [0, 0.625],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total diterima bulan ini',
                    style: T.s.copyWith(color: AppColors.merk100)),
                const SizedBox(height: 12),
                Text('Rp 186.400', style: T.xl.copyWith(color: AppColors.putih)),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    _MiniPill('7 transaksi'),
                    SizedBox(width: 8),
                    _MiniPill('64 kg rongsok'),
                  ],
                ),
                const SizedBox(height: 12),
                PrimaryButton.amber(
                  label: 'Ajukan Penjemputan',
                  onTap: () => Navigator.pushNamed(context, R.a1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader('Permintaan Berjalan',
              action: 'Lihat semua',
              onAction: () => Navigator.pushNamed(context, R.wRinci)),
          const SizedBox(height: 16),
          RequestCard(
            code: 'RSK-00131',
            status: 'Dijadwalkan',
            tone: Tone.sky,
            title: 'Lapak Hijau Karawang',
            schedule: 'Sab, 4 Okt · 09.00–11.00',
            summary: '3 jenis · ±18 kg',
            amount: '± Rp 42.600',
            onTap: () => Navigator.pushNamed(context, R.wRinci),
          ),
          const SizedBox(height: 16),
          RequestCard(
            code: 'RSK-00127',
            status: 'Menunggu Konfirmasi',
            tone: Tone.violet,
            title: 'Pengepul Jaya',
            schedule: 'Hari ini · ditimbang 10.12',
            summary: '2 jenis · 11,4 kg',
            amount: 'Rp 32.700',
            onTap: () => Navigator.pushNamed(context, R.wRinci),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Dampak Lingkunganmu'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DampakStat(
                  icon: LucideIcons.recycle,
                  value: '64 kg',
                  label: 'diselamatkan',
                  onTap: () => Navigator.pushNamed(context, R.dampak),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DampakStat(
                  icon: LucideIcons.leaf,
                  value: '112 kg',
                  label: 'CO₂ dicegah',
                  onTap: () => Navigator.pushNamed(context, R.dampak),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  final String text;
  const _MiniPill(this.text);
  @override
  Widget build(BuildContext context) => Pill(text,
      bg: AppColors.merk600,
      fg: AppColors.merk50,
      fontSize: 10,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4));
}

class _DampakStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final VoidCallback onTap;
  const _DampakStat(
      {required this.icon,
      required this.value,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBox(icon),
          const SizedBox(height: 8),
          Text(value, style: T.l),
          const SizedBox(height: 8),
          Text(label, style: T.s),
        ],
      ),
    );
  }
}

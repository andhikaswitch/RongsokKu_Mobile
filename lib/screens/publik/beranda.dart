import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.emerald,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.recycling, color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text('RongsokKu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, R.masuk),
                  child: const Text('Masuk',
                      style: TextStyle(
                          color: AppColors.emerald, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Hero
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.emerald, AppColors.emeraldDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Pill('♻ Jual rongsok jadi cuan',
                      bg: Color(0x33FFFFFF), fg: Colors.white),
                  const SizedBox(height: 14),
                  const Text(
                    'Ubah sampahmu\njadi rupiah',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        height: 1.2,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hubungkan dengan pengepul terdekat, harga transparan, jemput ke rumah.',
                    style: TextStyle(color: Color(0xFFE6FFF4), fontSize: 14),
                  ),
                  const SizedBox(height: 18),
                  PrimaryButton(
                    label: 'Masuk',
                    icon: Icons.login,
                    onTap: () => Navigator.pushNamed(context, R.masuk),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _ActionTile(
                    icon: Icons.location_on_outlined,
                    label: 'Cari Pengepul\nTerdekat',
                    onTap: () => Navigator.pushNamed(context, R.cari),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _ActionTile(
                    icon: Icons.trending_up,
                    label: 'Lihat Harga\nPasar',
                    onTap: () => Navigator.pushNamed(context, R.harga),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SectionHeader('Harga hari ini',
                action: 'Lihat semua',
                onAction: () => Navigator.pushNamed(context, R.harga)),
            const SizedBox(height: 12),
            for (final h in _hargaPreview)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  onTap: () => Navigator.pushNamed(context, R.harga),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Text(h.$1, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(h.$2,
                                style: const TextStyle(fontWeight: FontWeight.w700)),
                            const Text('per kg',
                                style: TextStyle(
                                    color: AppColors.inkMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                      Text(h.$3,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, color: AppColors.emerald)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

const _hargaPreview = [
  ('🧴', 'Botol Plastik PET', 'Rp 4.000'),
  ('📦', 'Kardus Bekas', 'Rp 2.500'),
  ('🥫', 'Kaleng Alumunium', 'Rp 12.000'),
];

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.emeraldLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.emerald),
          ),
          const SizedBox(height: 12),
          Text(label,
              style: const TextStyle(fontWeight: FontWeight.w700, height: 1.2)),
        ],
      ),
    );
  }
}

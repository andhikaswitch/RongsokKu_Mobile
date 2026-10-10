import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class PengepulDashboard extends StatelessWidget {
  const PengepulDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: pengepulNav(context, 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.emeraldLight,
                  child: Text('🚛', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Pengepul Pak Budi',
                        style:
                            TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text('⭐ 4.7 • Aktif',
                        style:
                            TextStyle(color: AppColors.inkMuted, fontSize: 13)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Saldo + aksi
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.emerald, AppColors.emeraldDark],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saldo dompet',
                      style: TextStyle(color: Color(0xFFD1FAE5))),
                  const SizedBox(height: 6),
                  const Text('Rp 1.250.000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _MiniBtn(
                          icon: Icons.add,
                          label: 'Isi Saldo',
                          onTap: () => Navigator.pushNamed(context, R.dompet),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MiniBtn(
                          icon: Icons.history,
                          label: 'Riwayat',
                          onTap: () => Navigator.pushNamed(context, R.dompet),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: _Stat('8', 'Permintaan baru')),
                SizedBox(width: 12),
                Expanded(child: _Stat('126 kg', 'Minggu ini')),
              ],
            ),
            const SizedBox(height: 24),
            SectionHeader('Permintaan masuk',
                action: 'Semua',
                onAction: () => Navigator.pushNamed(context, R.pMasuk)),
            const SizedBox(height: 12),
            for (final r in _permintaan)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  onTap: () => Navigator.pushNamed(context, R.timbang),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(r.$1, style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.$2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                Text(r.$3,
                                    style: const TextStyle(
                                        color: AppColors.inkMuted, fontSize: 13)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right,
                              color: AppColors.inkMuted),
                        ],
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Terima & Jadwalkan',
                        onTap: () => Navigator.pushNamed(context, R.timbang),
                      ),
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

const _permintaan = [
  ('🧴', 'Botol plastik ±5 kg', 'Andhika • 0.6 km'),
  ('📦', 'Kardus ±8 kg', 'Sari • 1.1 km'),
];

class _MiniBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MiniBtn({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          Text(label,
              style: const TextStyle(color: AppColors.inkMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

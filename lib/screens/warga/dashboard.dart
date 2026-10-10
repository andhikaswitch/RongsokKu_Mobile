import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class WargaDashboard extends StatelessWidget {
  const WargaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: wargaNav(context, 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.emeraldLight,
                  child: Text('👤', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Halo, Andhika 👋',
                        style:
                            TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text('Warga • Cikampek',
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
            // Saldo poin
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
                  const Text('Total penghasilan',
                      style: TextStyle(color: Color(0xFFD1FAE5))),
                  const SizedBox(height: 6),
                  const Text('Rp 184.500',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text('12 kg terjual • 3 penjemputan',
                      style: TextStyle(color: Color(0xFFD1FAE5), fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Ajukan Penjemputan',
              icon: Icons.local_shipping_outlined,
              onTap: () => Navigator.pushNamed(context, R.a1),
            ),
            const SizedBox(height: 24),
            SectionHeader('Permintaan aktif',
                action: 'Semua',
                onAction: () => Navigator.pushNamed(context, R.wRinci)),
            const SizedBox(height: 12),
            for (final r in _permintaan)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  onTap: () => Navigator.pushNamed(context, R.wRinci),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.emeraldLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(r.$1, style: const TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.$2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            Text(r.$3,
                                style: const TextStyle(
                                    color: AppColors.inkMuted, fontSize: 13)),
                          ],
                        ),
                      ),
                      Pill(r.$4, bg: r.$5, fg: r.$6),
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
  ('🧴', 'Botol plastik ±5 kg', 'Bank Sampah Melati', 'Dijemput',
      AppColors.amberLight, AppColors.amber),
  ('📦', 'Kardus ±8 kg', 'Pengepul Pak Budi', 'Menunggu',
      Color(0xFFE0F2FE), Color(0xFF0284C7)),
];

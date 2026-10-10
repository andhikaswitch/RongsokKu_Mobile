import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class SengketaScreen extends StatelessWidget {
  const SengketaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Putuskan Sengketa'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.warning_amber_rounded, color: AppColors.danger),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Sengketa berat timbangan',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: AppColors.danger)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _Pihak(
            emoji: '👤',
            nama: 'Andhika (Warga)',
            klaim: 'Berat seharusnya 13 kg, tapi dicatat 9 kg.',
          ),
          const SizedBox(height: 12),
          const _Pihak(
            emoji: '🚛',
            nama: 'Pak Budi (Pengepul)',
            klaim: 'Timbangan menunjukkan 9 kg sesuai foto.',
          ),
          const SizedBox(height: 16),
          const SectionHeader('Bukti'),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.line),
            ),
            child: const Center(
              child: Icon(Icons.image_outlined,
                  size: 40, color: AppColors.inkMuted),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Putuskan Sengketa',
            icon: Icons.gavel_rounded,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Keputusan tersimpan')),
              );
              Navigator.pushNamedAndRemoveUntil(context, R.adDash, (r) => false);
            },
          ),
        ],
      ),
    );
  }
}

class _Pihak extends StatelessWidget {
  final String emoji;
  final String nama;
  final String klaim;
  const _Pihak({required this.emoji, required this.nama, required this.klaim});
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(klaim,
                    style: const TextStyle(
                        color: AppColors.inkMuted, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

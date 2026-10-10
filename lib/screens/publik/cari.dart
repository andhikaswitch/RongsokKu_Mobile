import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class CariScreen extends StatelessWidget {
  const CariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Pengepul Terdekat'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const AppTextField(
              hint: 'Cari nama atau lokasi…', icon: Icons.search),
          const SizedBox(height: 16),
          const Text('5 pengepul di sekitarmu',
              style: TextStyle(color: AppColors.inkMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          for (final p in _pengepul)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => Navigator.pushNamed(context, R.detail),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.emeraldLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(p.$1, style: const TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.$2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 15)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 15, color: AppColors.amber),
                              const SizedBox(width: 3),
                              Text('${p.$3}  •  ${p.$4}',
                                  style: const TextStyle(
                                      color: AppColors.inkMuted, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (p.$5)
                      const Pill('Buka',
                          bg: AppColors.emeraldLight, fg: AppColors.emeraldDark)
                    else
                      const Pill('Tutup',
                          bg: Color(0xFFF1F5F9), fg: AppColors.inkMuted),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

const _pengepul = [
  ('♻', 'Bank Sampah Melati', '4.9', '0.6 km', true),
  ('🚛', 'Pengepul Pak Budi', '4.7', '1.2 km', true),
  ('🏭', 'Rongsok Jaya Abadi', '4.8', '2.0 km', true),
  ('♻', 'TPS3R Harapan', '4.5', '2.8 km', false),
  ('🚛', 'Lapak Bu Sari', '4.6', '3.1 km', true),
];

import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class PengepulMasuk extends StatelessWidget {
  const PengepulMasuk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permintaan Masuk',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      bottomNavigationBar: pengepulNav(context, 1),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          const Text('8 permintaan menunggu dijadwalkan',
              style: TextStyle(color: AppColors.inkMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          for (final r in _data)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => Navigator.pushNamed(context, R.timbang),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(r.$3,
                              style: const TextStyle(
                                  color: AppColors.inkMuted, fontSize: 13)),
                        ],
                      ),
                    ),
                    Pill(r.$4,
                        bg: AppColors.amberLight, fg: AppColors.amber),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

const _data = [
  ('🧴', 'Botol plastik ±5 kg', 'Andhika • Jl. Melati', 'Baru'),
  ('📦', 'Kardus ±8 kg', 'Sari • Jl. Mawar', 'Baru'),
  ('🥫', 'Kaleng ±3 kg', 'Budi • Jl. Anggrek', 'Baru'),
  ('📰', 'Koran ±10 kg', 'Tono • Jl. Kenanga', 'Besok'),
];

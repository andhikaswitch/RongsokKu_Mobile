import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class TerbukaScreen extends StatelessWidget {
  const TerbukaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permintaan Terbuka',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      bottomNavigationBar: pengepulNav(context, 2),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.emeraldLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: const [
                Icon(Icons.public, color: AppColors.emeraldDark),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Permintaan dari warga yang belum diambil pengepul lain.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final r in _data)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
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
                        Text(r.$4,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.emerald)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    OutlineButton(
                      label: 'Ambil Permintaan',
                      onTap: () => Navigator.pushNamed(context, R.timbang),
                    ),
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
  ('🧴', 'Botol plastik ±6 kg', '2.0 km', '± Rp 24.000'),
  ('📦', 'Kardus ±12 kg', '2.8 km', '± Rp 30.000'),
  ('🥫', 'Kaleng ±4 kg', '3.1 km', '± Rp 48.000'),
];

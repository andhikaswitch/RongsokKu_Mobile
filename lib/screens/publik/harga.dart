import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class HargaScreen extends StatelessWidget {
  const HargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Harga Pasar'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.amberLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.amber),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Harga acuan per kg. Bisa berbeda tiap pengepul & lokasi.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (final kategori in _data) ...[
            Text(kategori.$1,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            for (final item in kategori.$2)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  onTap: () => Navigator.pushNamed(context, R.cari),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Text(item.$1, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.$2,
                                style:
                                    const TextStyle(fontWeight: FontWeight.w700)),
                            Text('Acuan ${item.$3} / kg',
                                style: const TextStyle(
                                    color: AppColors.inkMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.inkMuted),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

const _data = [
  ('Plastik', [
    ('🧴', 'Botol PET bening', 'Rp 4.000'),
    ('🪣', 'Plastik keras', 'Rp 3.000'),
    ('🛍', 'Kresek campur', 'Rp 1.000'),
  ]),
  ('Kertas', [
    ('📦', 'Kardus bekas', 'Rp 2.500'),
    ('📰', 'Koran', 'Rp 2.000'),
    ('📄', 'HVS / buku', 'Rp 3.500'),
  ]),
  ('Logam', [
    ('🥫', 'Kaleng alumunium', 'Rp 12.000'),
    ('🔩', 'Besi', 'Rp 5.000'),
    ('🧵', 'Tembaga', 'Rp 75.000'),
  ]),
];

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';

class HargaScreen extends StatefulWidget {
  const HargaScreen({super.key});

  @override
  State<HargaScreen> createState() => _HargaScreenState();
}

class _HargaScreenState extends State<HargaScreen> {
  int _filter = 0;
  static const _filters = ['Semua', 'Kertas', 'Plastik', 'Logam', 'Kaca'];

  @override
  Widget build(BuildContext context) {
    final shown = _filter == 0
        ? _data
        : _data.where((k) => k.$2 == _filters[_filter]).toList();
    return Scaffold(
      appBar: subBar('Pusat Harga', 'Indeks dari transaksi 30 hari terakhir'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu ringkasan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.merk700,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Rata-rata perubahan minggu ini',
                          style: T.s.copyWith(color: AppColors.merk100)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.merk600,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.trendingUp,
                              size: 12, color: AppColors.merk50),
                          const SizedBox(width: 4),
                          Text('+1,4%',
                              style: T.xs.copyWith(color: AppColors.merk50)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('21 jenis rongsok · 420 transaksi',
                    style: T.m.copyWith(color: AppColors.putih)),
                const SizedBox(height: 10),
                const Sparkline(
                  points: [3, 3.4, 3.1, 3.8, 3.6, 4.2, 4, 4.6, 4.4, 5, 4.9, 5.4],
                  color: AppColors.nilai500,
                  height: 36,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const AppTextField(
              hint: 'Cari jenis rongsok…', icon: LucideIcons.search),
          const SizedBox(height: 12),
          FilterChips(
            items: _filters,
            selected: _filter,
            onSelected: (i) => setState(() => _filter = i),
          ),
          const SizedBox(height: 12),
          for (final k in shown) ...[
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Row(
                      children: [
                        Text(k.$1, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Expanded(child: Text(k.$2, style: T.bodyBold)),
                        Text('${k.$3.length} jenis', style: T.s),
                      ],
                    ),
                  ),
                  for (final it in k.$3) ...[
                    const Sep(),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          EmojiTile(it.$1, size: 40),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(it.$2, style: T.bodyBold),
                                Text('Acuan ${it.$3}/kg', style: T.s),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(it.$4, style: T.bodyBold),
                              TrendText(it.$5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

const _data = [
  ('📄', 'Kertas', [
    ('📄', 'Kardus', 'Rp 1.800–2.600', 'Rp 2.400', 3.2),
    ('📰', 'Koran', 'Rp 2.000–3.000', 'Rp 2.700', 0.8),
    ('📚', 'HVS / Buku', 'Rp 2.500–3.500', 'Rp 3.100', 0.0),
  ]),
  ('🧴', 'Plastik', [
    ('🧴', 'Botol PET', 'Rp 3.500–5.000', 'Rp 4.100', 1.8),
    ('🪣', 'Plastik Keras', 'Rp 2.000–3.200', 'Rp 2.600', -2.1),
  ]),
  ('🔩', 'Logam', [
    ('🔩', 'Besi', 'Rp 4.500–6.000', 'Rp 5.300', -0.9),
    ('🥫', 'Aluminium', 'Rp 10.000–14.000', 'Rp 12.000', 1.1),
  ]),
  ('🍾', 'Kaca', [
    ('🍾', 'Botol Kaca', 'Rp 300–700', 'Rp 500', 0.0),
  ]),
];

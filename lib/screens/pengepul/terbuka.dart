import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class TerbukaScreen extends StatefulWidget {
  const TerbukaScreen({super.key});

  @override
  State<TerbukaScreen> createState() => _TerbukaScreenState();
}

class _TerbukaScreenState extends State<TerbukaScreen> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Permintaan Terbuka', 'Siapa cepat, dia dapat'),
      bottomNavigationBar: pengepulNav(context, 2),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const InfoBox(
            icon: LucideIcons.zap,
            title: 'Permintaan tanpa pengepul tujuan',
            text: 'Warga di radius 5 km menyiarkan barangnya. Ambil sebelum '
                'lapak lain.',
            textColor: AppColors.slate600,
          ),
          const SizedBox(height: 12),
          FilterChips(
            items: const ['Semua', '≤ 2 km', 'Logam', 'Elektronik'],
            selected: _filter,
            onSelected: (i) => setState(() => _filter = i),
          ),
          const SizedBox(height: 12),
          for (final r in _data) ...[
            _OpenCard(
              code: r.$1,
              ago: r.$2,
              place: r.$3,
              tags: r.$4,
              value: r.$5,
              onTake: () => Navigator.pushNamed(context, R.timbang),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

const _data = [
  ('RSK-00136', '12 menit lalu', 'Karawang Barat · 1,1 km',
      ['Besi ±15 kg', 'Aluminium ±3 kg'], '± Rp 103.500'),
  ('RSK-00135', '40 menit lalu', 'Telukjambe Timur · 3,4 km',
      ['TV tabung 1 unit', 'Kabel ±2 kg'], '± Rp 64.000'),
];

class _OpenCard extends StatelessWidget {
  final String code;
  final String ago;
  final String place;
  final List<String> tags;
  final String value;
  final VoidCallback onTake;
  const _OpenCard({
    required this.code,
    required this.ago,
    required this.place,
    required this.tags,
    required this.value,
    required this.onTake,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(code,
                    style: T.label.copyWith(color: AppColors.slate500)),
              ),
              const Icon(LucideIcons.clock,
                  size: 13, color: AppColors.slate500),
              const SizedBox(width: 4),
              Text(ago, style: T.s),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(LucideIcons.mapPin,
                  size: 16, color: AppColors.merk600),
              const SizedBox(width: 6),
              Expanded(child: Text(place, style: T.bodyBold)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final t in tags)
                Pill(t,
                    bg: AppColors.slate100,
                    fg: AppColors.slate600,
                    fontSize: 10,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
            ],
          ),
          const SizedBox(height: 12),
          const Sep(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estimasi nilai', style: T.s),
                    Text(value, style: T.m.copyWith(color: AppColors.nilai700)),
                  ],
                ),
              ),
              PrimaryButton(
                  label: 'Ambil Permintaan', expand: false, onTap: onTake),
            ],
          ),
        ],
      ),
    );
  }
}

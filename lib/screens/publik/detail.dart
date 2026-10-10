import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Lapak Hijau Karawang', 'Kec. Karawang Barat · 0,8 km'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          // Kartu identitas + statistik
          AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    const InitialAvatar('HK', size: 52),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Lapak Hijau Karawang',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800)),
                        SizedBox(height: 4),
                        VerifiedBadge(showText: true),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(child: _Stat('4,9 ★', 'Rating')),
                    _VDivider(),
                    Expanded(child: _Stat('128', 'Transaksi')),
                    _VDivider(),
                    Expanded(child: _Stat('2,4 t', 'Terkumpul')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Rekam jejak objektif
          AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('Rekam jejak objektif',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800)),
                    Spacer(),
                    Icon(LucideIcons.info,
                        size: 18, color: AppColors.inkMuted),
                  ],
                ),
                const SizedBox(height: 16),
                const MetricBar(label: 'Kepatuhan harga', percent: 96),
                const SizedBox(height: 14),
                const MetricBar(label: 'Tepat waktu', percent: 91),
                const SizedBox(height: 14),
                const MetricBar(
                    label: 'Tingkat penerimaan',
                    percent: 88,
                    color: AppColors.nilai500),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Harga beli per kg
          AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('Harga beli per kg',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800)),
                    Spacer(),
                    Text('Diperbarui kemarin',
                        style: TextStyle(
                            color: AppColors.inkMuted, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 14),
                _HargaRow(
                  emoji: '📦',
                  name: 'Kardus',
                  indeks: 'Indeks Rp 2.400 · sesuai',
                  price: 'Rp 2.500',
                  note: '▲ di atas indeks',
                  noteColor: AppColors.emerald,
                ),
                const Divider(height: 24, color: AppColors.line),
                _HargaRow(
                  emoji: '🧴',
                  name: 'Botol PET',
                  indeks: 'Indeks Rp 4.100 · sesuai',
                  price: 'Rp 4.000',
                  note: 'sesuai',
                  noteColor: AppColors.inkMuted,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.slate200),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(LucideIcons.messageCircle,
                    size: 20, color: AppColors.merk700),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PrimaryButton(
                label: 'Ajukan Penjemputan',
                onTap: () => Navigator.pushNamed(context, R.a1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HargaRow extends StatelessWidget {
  final String emoji, name, indeks, price, note;
  final Color noteColor;
  const _HargaRow({
    required this.emoji,
    required this.name,
    required this.indeks,
    required this.price,
    required this.note,
    required this.noteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14.5)),
              const SizedBox(height: 2),
              Text(indeks,
                  style: const TextStyle(
                      color: AppColors.inkMuted, fontSize: 12)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(height: 2),
            Text(note,
                style: TextStyle(
                    color: noteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(color: AppColors.inkMuted, fontSize: 12)),
      ],
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: AppColors.line);
}

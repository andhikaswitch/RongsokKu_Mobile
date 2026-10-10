import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.putih,
      body: SafeArea(
        child: ListView(
          children: [
            // Bagian hero (putih)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BrandLogo(),
                      const Spacer(),
                      SizedBox(
                        height: 36,
                        child: FilledButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, R.masuk),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.merk50,
                            foregroundColor: AppColors.merk800,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textStyle: T.label,
                          ),
                          child: const Text('Masuk'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.merk50,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.merk100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.zap,
                            size: 12, color: AppColors.merk700),
                        const SizedBox(width: 6),
                        Text('Harga diperbarui dari transaksi nyata',
                            style: T.xs.copyWith(color: AppColors.merk800)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                          fontSize: 32,
                          height: 38 / 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8),
                      children: const [
                        TextSpan(
                            text: 'Rongsok di rumah\n',
                            style: TextStyle(color: AppColors.slate900)),
                        TextSpan(
                            text: 'punya harga.',
                            style: TextStyle(color: AppColors.merk600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Bandingkan harga antar pengepul di sekitarmu, pilih yang '
                    'paling cocok, lalu barangmu dijemput langsung ke rumah. '
                    'Dibayar tunai di tempat.',
                    style: T.body.copyWith(color: AppColors.slate600),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: 'Cari Pengepul Terdekat',
                    onTap: () => Navigator.pushNamed(context, R.cari),
                  ),
                  const SizedBox(height: 10),
                  OutlineButton(
                    label: 'Lihat Harga Pasar',
                    onTap: () => Navigator.pushNamed(context, R.harga),
                  ),
                ],
              ),
            ),
            // Bagian bawah (slate/50)
            Container(
              color: AppColors.slate50,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _Stat('12.480 kg', 'diselamatkan dari TPA')),
                      SizedBox(width: 12),
                      Expanded(child: _Stat('420', 'transaksi selesai')),
                      SizedBox(width: 12),
                      Expanded(child: _Stat('8', 'pengepul terverifikasi')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AppCard(
                    onTap: () => Navigator.pushNamed(context, R.harga),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('INDEKS RONGSOKKU',
                                      style: T.xs.copyWith(
                                          color: AppColors.merk700,
                                          letterSpacing: 0.6)),
                                  Text('Dari transaksi 30 hari terakhir',
                                      style: T.s),
                                ],
                              ),
                            ),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                  color: AppColors.merk500,
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Text('Aktif',
                                style:
                                    T.label.copyWith(color: AppColors.merk700)),
                          ],
                        ),
                        for (final it in _indeks) ...[
                          const SizedBox(height: 12),
                          const Sep(),
                          const SizedBox(height: 12),
                          _IndeksRow(it),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _indeks = [
  ('📄', 'Kardus', '34 transaksi', 'Rp 2.400', 3.2),
  ('🧴', 'Botol PET', '51 transaksi', 'Rp 4.100', 1.8),
  ('🔩', 'Besi', '27 transaksi', 'Rp 5.300', -0.9),
];

class _IndeksRow extends StatelessWidget {
  final (String, String, String, String, double) data;
  const _IndeksRow(this.data);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EmojiTile(data.$1, size: 40),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.$2, style: T.bodyBold),
              Text(data.$3, style: T.s),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(data.$4, style: T.bodyBold),
            TrendText(data.$5),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: T.l),
        const SizedBox(height: 2),
        Text(label, style: T.s),
      ],
    );
  }
}

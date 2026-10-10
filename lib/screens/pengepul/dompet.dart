import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class DompetScreen extends StatelessWidget {
  const DompetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Dompet & Saldo', 'Deposit untuk komisi platform'),
      bottomNavigationBar: pengepulNav(context, 4),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu saldo
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.merk700, Color(0xFF069669)],
                stops: [0, 0.625],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saldo tersedia',
                    style: T.s.copyWith(color: AppColors.merk100)),
                const SizedBox(height: 6),
                Text('Rp 148.500', style: T.xl.copyWith(color: AppColors.putih)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: 0.74,
                    minHeight: 6,
                    backgroundColor: AppColors.putih.withValues(alpha: 0.2),
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.nilai500),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Batas minimum Rp 50.000',
                        style: T.xs.copyWith(
                            color: AppColors.merk100,
                            fontWeight: FontWeight.w400)),
                    Text('≈ 59 transaksi lagi',
                        style: T.xs.copyWith(
                            color: AppColors.merk100,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                const SizedBox(height: 14),
                PrimaryButton.amber(label: 'Isi Saldo via Transfer', onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            color: AppColors.sky50,
            borderColor: const Color(0xFFBAE6FD),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const IconBox(LucideIcons.clock,
                    bg: AppColors.putih, fg: AppColors.sky700),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Top-up Rp 200.000 diproses',
                          style: T.bodyBold.copyWith(color: AppColors.sky700)),
                      Text('Bukti transfer sedang diverifikasi admin',
                          style: T.s.copyWith(color: AppColors.sky700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Mutasi Saldo', action: 'Unduh CSV'),
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Column(
              children: [
                for (int i = 0; i < _mutasi.length; i++) ...[
                  if (i > 0) const Sep(),
                  _MutasiRow(_mutasi[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _mutasi = [
  (LucideIcons.wallet, 'Top-up disetujui', '28 Sep · TOP-00041', '+ Rp 200.000', true),
  (LucideIcons.recycle, 'Komisi RSK-00127', 'Hari ini · 5% × Rp 32.700', '− Rp 1.635', false),
  (LucideIcons.recycle, 'Komisi RSK-00124', '30 Sep · 5% × Rp 88.200', '− Rp 4.410', false),
  (LucideIcons.recycle, 'Komisi RSK-00119', '29 Sep · 5% × Rp 51.400', '− Rp 2.570', false),
  (LucideIcons.shieldCheck, 'Penyesuaian sengketa', '27 Sep · SKT-00001', '+ Rp 1.200', true),
];

class _MutasiRow extends StatelessWidget {
  final (IconData, String, String, String, bool) m;
  const _MutasiRow(this.m);

  @override
  Widget build(BuildContext context) {
    final masuk = m.$5;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          IconBox(m.$1,
              size: 36,
              bg: masuk ? AppColors.merk50 : AppColors.slate100,
              fg: masuk ? AppColors.merk700 : AppColors.slate600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.$2, style: T.bodyBold),
                Text(m.$3, style: T.s),
              ],
            ),
          ),
          Text(m.$4,
              style: T.bodyBold.copyWith(
                  color: masuk ? AppColors.merk600 : AppColors.slate900)),
        ],
      ),
    );
  }
}

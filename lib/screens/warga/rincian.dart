import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class RincianScreen extends StatelessWidget {
  const RincianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('RSK-00127', 'Pengepul Jaya'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status permintaan
          AppCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status permintaan', style: T.bodyBold),
                    const StatusPill('Menunggu Konfirmasi', tone: Tone.violet),
                  ],
                ),
                const SizedBox(height: 16),
                const _Tracker(
                  labels: [
                    'Diajukan',
                    'Dijadwal',
                    'Dijemput',
                    'Ditimbang',
                    'Selesai'
                  ],
                  current: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Hasil timbang
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const IconBox(LucideIcons.scale,
                        bg: AppColors.violet50, fg: AppColors.violet600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hasil timbang di tempat', style: T.bodyBold),
                          Text('Hari ini, 10.12 · oleh Pak Darto', style: T.s),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _TimbangRow('Kardus', 'est. 10 kg → 8,6 kg · × Rp 2.500',
                    'Rp 21.500'),
                const SizedBox(height: 12),
                const _TimbangRow('Botol PET',
                    'est. 2 kg → 2,8 kg · × Rp 4.000', 'Rp 11.200'),
                const SizedBox(height: 14),
                const Sep(),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total dibayar tunai',
                        style: T.body.copyWith(color: AppColors.slate600)),
                    Text('Rp 32.700',
                        style: T.l.copyWith(color: AppColors.nilai700)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const InfoBox(
            icon: LucideIcons.triangleAlert,
            title: 'Berat Kardus 14% di bawah estimasi',
            text: 'Ini hanya peringatan. Cek kembali timbangan bersama '
                'pengepul sebelum konfirmasi.',
            textColor: AppColors.slate600,
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              label: 'Konfirmasi & Terima Tunai',
              onTap: () => Navigator.pushNamed(context, R.dampak),
            ),
            const SizedBox(height: 10),
            OutlineButton(
              label: 'Ajukan Sengketa',
              color: AppColors.rose600,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _TimbangRow extends StatelessWidget {
  final String name;
  final String detail;
  final String total;
  const _TimbangRow(this.name, this.detail, this.total);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: T.bodyBold),
              const SizedBox(height: 2),
              Text(detail, style: T.s),
            ],
          ),
        ),
        Text(total, style: T.bodyBold),
      ],
    );
  }
}

/// Pelacak status 5 langkah; langkah aktif berwarna violet.
class _Tracker extends StatelessWidget {
  final List<String> labels;
  final int current;
  const _Tracker({required this.labels, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 1; i <= labels.length; i++)
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < current
                        ? AppColors.merk600
                        : i == current
                            ? AppColors.violet600
                            : AppColors.slate100,
                  ),
                  child: i < current
                      ? const Icon(LucideIcons.check,
                          size: 14, color: AppColors.putih)
                      : Text('$i',
                          style: T.label.copyWith(
                              color: i == current
                                  ? AppColors.putih
                                  : AppColors.slate400)),
                ),
                const SizedBox(height: 6),
                Text(labels[i - 1],
                    style: T.xs.copyWith(
                        color: i <= current
                            ? AppColors.slate700
                            : AppColors.slate400)),
              ],
            ),
          ),
      ],
    );
  }
}

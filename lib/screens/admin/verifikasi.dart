import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';

class VerifikasiScreen extends StatelessWidget {
  const VerifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Verifikasi Pengepul', 'Diajukan 2 hari lalu'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const InitialAvatar('MB',
                        size: 44, bg: AppColors.nilai100, fg: AppColors.nilai700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rongsok Maju Bersama', style: T.m),
                          Text('Ujang Maju · maju@pengepul.test', style: T.s),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const StatusPill('Menunggu Verifikasi', tone: Tone.orange),
                const SizedBox(height: 14),
                const Sep(),
                const SizedBox(height: 4),
                const _KV('NIK', '3215 •••• •••• 0042'),
                const _KV('Alamat lapak', 'Jl. Raya Klari No. 88, Klari'),
                const _KV('Jam operasional', '07.00–17.00'),
                const _KV('Izin limbah B3', 'Tidak ada'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Dokumen', style: T.m),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: _Dokumen(LucideIcons.user, 'Foto KTP')),
              SizedBox(width: 10),
              Expanded(child: _Dokumen(LucideIcons.store, 'Foto lapak')),
            ],
          ),
          const SizedBox(height: 16),
          const FieldLabel('Catatan untuk pemohon (wajib jika ditolak)'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'Contoh: foto KTP buram, unggah ulang'),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Row(
          children: [
            Expanded(
              child: OutlineButton(
                label: 'Tolak',
                color: AppColors.rose600,
                onTap: () => Navigator.maybePop(context),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PrimaryButton(
                label: 'Setujui',
                onTap: () => Navigator.maybePop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KV extends StatelessWidget {
  final String k;
  final String v;
  const _KV(this.k, this.v);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(k, style: T.s),
          const SizedBox(width: 12),
          Expanded(
            child: Text(v, textAlign: TextAlign.right, style: T.label),
          ),
        ],
      ),
    );
  }
}

class _Dokumen extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Dokumen(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 92,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 28, color: AppColors.slate400),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(label,
                    style: T.label.copyWith(color: AppColors.slate700)),
              ),
              const Icon(LucideIcons.circleCheck,
                  size: 16, color: AppColors.merk600),
            ],
          ),
        ],
      ),
    );
  }
}

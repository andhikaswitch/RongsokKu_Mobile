import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class VerifikasiScreen extends StatelessWidget {
  const VerifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Verifikasi Pengepul'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.emeraldLight,
                  child: Text('🚛', style: TextStyle(fontSize: 30)),
                ),
                SizedBox(height: 12),
                Text('Rongsok Jaya Abadi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                Text('Mendaftar 9 Okt 2026',
                    style: TextStyle(color: AppColors.inkMuted, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              children: const [
                _Baris('Pemilik', 'Bpk. Suharto'),
                Divider(height: 24, color: AppColors.line),
                _Baris('NIK', '3215xxxxxxxx0007'),
                Divider(height: 24, color: AppColors.line),
                _Baris('Alamat', 'Jl. Industri No. 22'),
                Divider(height: 24, color: AppColors.line),
                _Baris('Telepon', '0812-3456-7890'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Dokumen'),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _Doc('KTP', Icons.badge_outlined)),
              SizedBox(width: 12),
              Expanded(child: _Doc('Izin Usaha', Icons.description_outlined)),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Setujui',
            icon: Icons.check_rounded,
            onTap: () => _selesai(context, 'Pengepul disetujui'),
          ),
          const SizedBox(height: 10),
          OutlineButton(
            label: 'Tolak',
            color: AppColors.danger,
            onTap: () => _selesai(context, 'Pengajuan ditolak'),
          ),
        ],
      ),
    );
  }

  void _selesai(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(pesan)));
    Navigator.pushNamedAndRemoveUntil(context, R.adDash, (r) => false);
  }
}

class _Baris extends StatelessWidget {
  final String k;
  final String v;
  const _Baris(this.k, this.v);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(k, style: const TextStyle(color: AppColors.inkMuted)),
        Text(v, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _Doc extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Doc(this.label, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.emerald, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

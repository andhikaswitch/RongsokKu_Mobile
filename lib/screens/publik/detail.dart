import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Detail Pengepul'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.emeraldLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: const Text('♻', style: TextStyle(fontSize: 30)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bank Sampah Melati',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.star, size: 16, color: AppColors.amber),
                        SizedBox(width: 4),
                        Text('4.9 (128 ulasan)',
                            style: TextStyle(color: AppColors.inkMuted)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(child: _Stat('0.6 km', 'Jarak')),
              SizedBox(width: 12),
              Expanded(child: _Stat('08.00–17.00', 'Jam buka')),
              SizedBox(width: 12),
              Expanded(child: _Stat('Gratis', 'Jemput')),
            ],
          ),
          const SizedBox(height: 20),
          const SectionHeader('Jenis diterima'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Pill('🧴 Plastik', bg: AppColors.emeraldLight, fg: AppColors.emeraldDark),
              Pill('📦 Kertas', bg: AppColors.emeraldLight, fg: AppColors.emeraldDark),
              Pill('🥫 Logam', bg: AppColors.emeraldLight, fg: AppColors.emeraldDark),
              Pill('🍾 Kaca', bg: AppColors.emeraldLight, fg: AppColors.emeraldDark),
            ],
          ),
          const SizedBox(height: 20),
          const SectionHeader('Tentang'),
          const SizedBox(height: 10),
          const Text(
            'Bank sampah terpercaya dengan timbangan tersertifikasi. '
            'Harga mengikuti harga pasar, pembayaran tunai saat penjemputan.',
            style: TextStyle(color: AppColors.inkMuted, height: 1.5),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Ajukan Penjemputan',
            icon: Icons.local_shipping_outlined,
            onTap: () => Navigator.pushNamed(context, R.a1),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          Text(value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(color: AppColors.inkMuted, fontSize: 12)),
        ],
      ),
    );
  }
}

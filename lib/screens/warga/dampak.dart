import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class DampakScreen extends StatelessWidget {
  const DampakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dampak Lingkungan',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      bottomNavigationBar: wargaNav(context, 4),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.emerald, AppColors.emeraldDark],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('🌍', style: TextStyle(fontSize: 34)),
                SizedBox(height: 12),
                Text('Kamu sudah menyelamatkan',
                    style: TextStyle(color: Color(0xFFD1FAE5))),
                SizedBox(height: 4),
                Text('47 kg sampah',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800)),
                Text('dari tempat pembuangan akhir',
                    style: TextStyle(color: Color(0xFFD1FAE5))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: _Metric('🌳', '2', 'Pohon setara')),
              SizedBox(width: 12),
              Expanded(child: _Metric('💧', '310 L', 'Air dihemat')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _Metric('⚡', '18 kWh', 'Energi dihemat')),
              SizedBox(width: 12),
              Expanded(child: _Metric('☁', '26 kg', 'CO₂ dikurangi')),
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader('Lencana kamu'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _Badge('🥇', 'Pemula Hijau'),
              _Badge('♻', 'Rajin Daur Ulang'),
              _Badge('🔥', 'Streak 7 hari'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  const _Metric(this.emoji, this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          Text(label,
              style: const TextStyle(color: AppColors.inkMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String emoji;
  final String label;
  const _Badge(this.emoji, this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

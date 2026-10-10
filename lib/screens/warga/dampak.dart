import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class DampakScreen extends StatelessWidget {
  const DampakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Dampak & Lencana', 'Kontribusimu untuk lingkungan'),
      bottomNavigationBar: wargaNav(context, 4),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu total
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.merk800, AppColors.merk700],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Total diselamatkan dari TPA',
                          style: T.s.copyWith(color: AppColors.merk100)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.nilai500,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.trophy,
                              size: 12, color: AppColors.slate900),
                          const SizedBox(width: 4),
                          Text('Peringkat #7',
                              style: T.xs.copyWith(color: AppColors.slate900)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('64,2 kg', style: T.xl.copyWith(color: AppColors.putih)),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(child: _MiniStat('112 kg', 'CO₂ dicegah')),
                    SizedBox(width: 8),
                    Expanded(child: _MiniStat('3', 'pohon setara')),
                    SizedBox(width: 8),
                    Expanded(child: _MiniStat('7', 'transaksi')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader('Lencana Saya', action: '3 dari 8'),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.82,
            children: const [
              _Lencana(LucideIcons.leaf, 'Langkah Pertama', 'Transaksi pertama',
                  true),
              _Lencana(LucideIcons.recycle, 'Pahlawan Kardus', '50 kg kertas',
                  true),
              _Lencana(
                  LucideIcons.star, 'Penjual Teladan', '5 ulasan baik', true),
              _Lencana(LucideIcons.trophy, 'Top 10 Bulanan', 'Masuk peringkat',
                  false),
              _Lencana(
                  LucideIcons.truck, 'Rutin Jemput', '10 transaksi', false),
              _Lencana(LucideIcons.box, 'Serba Ada', '5 golongan', false),
            ],
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Menuju “Rutin Jemput”', style: T.bodyBold),
                    Text('7/10',
                        style: T.label.copyWith(color: AppColors.merk700)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: const LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 8,
                    backgroundColor: AppColors.slate100,
                    valueColor: AlwaysStoppedAnimation(AppColors.merk600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  const _MiniStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.putih.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: T.m.copyWith(color: AppColors.putih)),
          Text(label, style: T.xs.copyWith(color: AppColors.merk100)),
        ],
      ),
    );
  }
}

class _Lencana extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool earned;
  const _Lencana(this.icon, this.title, this.subtitle, this.earned);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: earned ? 1 : 0.55,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: earned ? AppColors.putih : AppColors.slate100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: earned ? AppColors.slate200 : AppColors.slate100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: earned ? AppColors.nilai100 : AppColors.slate200,
              ),
              child: Icon(icon,
                  size: 20,
                  color: earned ? AppColors.nilai700 : AppColors.slate400),
            ),
            const SizedBox(height: 8),
            Text(title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: T.label.copyWith(height: 1.2)),
            const SizedBox(height: 2),
            Text(subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: T.xs.copyWith(
                    color: AppColors.slate500, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

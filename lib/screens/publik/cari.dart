import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class CariScreen extends StatefulWidget {
  const CariScreen({super.key});

  @override
  State<CariScreen> createState() => _CariScreenState();
}

class _CariScreenState extends State<CariScreen> {
  int _filter = 1; // "Terdekat" aktif

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Cari Pengepul', '8 lapak terverifikasi di dekatmu'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          // Peta placeholder
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2EC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.line),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 150),
                  painter: _MapPainter(),
                ),
                const Positioned(
                  right: 8,
                  bottom: 6,
                  child: Text('© OpenStreetMap',
                      style:
                          TextStyle(color: AppColors.inkMuted, fontSize: 10)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          FilterChips(
            items: const [
              'Saring',
              'Terdekat',
              'Harga tertinggi',
              'Rating'
            ],
            selected: _filter,
            icons: const {0: LucideIcons.slidersHorizontal},
            onSelected: (i) => setState(() => _filter = i),
          ),
          const SizedBox(height: 16),
          for (final p in _pengepul)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => Navigator.pushNamed(context, R.detail),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InitialAvatar(p.initials, size: 44),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(p.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15)),
                                  ),
                                  const SizedBox(width: 5),
                                  const VerifiedBadge(),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(LucideIcons.mapPin,
                                      size: 13, color: AppColors.inkMuted),
                                  const SizedBox(width: 2),
                                  Text('${p.dist}  ',
                                      style: const TextStyle(
                                          color: AppColors.inkMuted,
                                          fontSize: 12.5)),
                                  const Icon(LucideIcons.star,
                                      size: 13, color: AppColors.amber),
                                  const SizedBox(width: 2),
                                  Text('${p.rating} · ${p.trx} transaksi',
                                      style: const TextStyle(
                                          color: AppColors.inkMuted,
                                          fontSize: 12.5)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final t in p.tags)
                          Pill(t,
                              bg: AppColors.slate100, fg: AppColors.slate600, fontSize: 10),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            size: 8,
                            color: p.open
                                ? AppColors.emerald
                                : AppColors.inkMuted),
                        const SizedBox(width: 6),
                        Text(p.open ? 'Buka · ${p.hours}' : 'Tutup sementara',
                            style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: p.open
                                    ? AppColors.emerald
                                    : AppColors.inkMuted)),
                        const Spacer(),
                        Row(
                          children: const [
                            Text('Lihat lapak',
                                style: TextStyle(
                                    color: AppColors.merk700,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            Icon(LucideIcons.chevronRight,
                                size: 18, color: AppColors.emerald),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _P {
  final String initials, name, dist, rating, hours;
  final int trx;
  final List<String> tags;
  final bool open;
  const _P(this.initials, this.name, this.dist, this.rating, this.trx,
      this.tags, this.open, this.hours);
}

const _pengepul = [
  _P('HK', 'Lapak Hijau Karawang', '0,6 km', '4.9', 128,
      ['Kertas', 'Plastik', 'Logam'], true, '07.00–17.00'),
  _P('PJ', 'Pengepul Jaya', '1,2 km', '4.8', 86,
      ['Logam', 'Elektronik'], true, '07.00–17.00'),
  _P('BJ', 'Barokah Jaya Mandiri', '2,3 km', '4.6', 41,
      ['Kertas', 'Kain'], false, ''),
];

/// Garis-garis jalan + titik lokasi sederhana untuk placeholder peta.
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawLine(
        Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.55), road);
    canvas.drawLine(
        Offset(size.width * 0.3, 0), Offset(size.width * 0.5, size.height), road);
    canvas.drawLine(Offset(size.width * 0.7, 0),
        Offset(size.width * 0.6, size.height), road);

    final dot = Paint()..color = AppColors.emerald;
    for (final o in [
      Offset(size.width * 0.35, size.height * 0.3),
      Offset(size.width * 0.6, size.height * 0.35),
      Offset(size.width * 0.5, size.height * 0.65),
      Offset(size.width * 0.8, size.height * 0.6),
    ]) {
      canvas.drawCircle(o, 5, dot);
    }
    // Lokasi pengguna (biru)
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.5), 6,
        Paint()..color = const Color(0xFF2563EB));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

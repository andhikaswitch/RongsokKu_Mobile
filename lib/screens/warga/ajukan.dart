import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

const _langkah = ['Pilih Pengepul', 'Barang', 'Alamat & Jadwal'];

// ═════════════════════ Langkah 1 — Pilih Pengepul ═════════════════════

class Ajukan1Screen extends StatefulWidget {
  const Ajukan1Screen({super.key});

  @override
  State<Ajukan1Screen> createState() => _Ajukan1State();
}

class _Ajukan1State extends State<Ajukan1Screen> {
  int _tab = 0;
  int _pilih = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Ajukan Penjemputan', 'Langkah 1 dari 3'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const StepIndicator(current: 1, labels: _langkah),
          const SizedBox(height: 12),
          _Segmented(
            items: const ['Pilih pengepul', 'Permintaan terbuka'],
            selected: _tab,
            onChanged: (i) => setState(() => _tab = i),
          ),
          const SizedBox(height: 12),
          Text(
            _tab == 0
                ? 'Pengepul terdekat dari Adiarsa Timur, urut jarak. Harga yang '
                    'tampil adalah harga beli lapak saat ini.'
                : 'Permintaanmu disiarkan ke semua pengepul dalam radius 5 km. '
                    'Pengepul pertama yang mengambil akan menjemput.',
            style: T.s,
          ),
          const SizedBox(height: 12),
          if (_tab == 0)
            for (int i = 0; i < _lapak.length; i++) ...[
              _LapakOption(
                data: _lapak[i],
                selected: _pilih == i,
                onTap: () => setState(() => _pilih = i),
              ),
              const SizedBox(height: 12),
            ],
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: PrimaryButton(
          label: 'Lanjut ke Barang',
          onTap: () => Navigator.pushNamed(context, R.a2),
        ),
      ),
    );
  }
}

const _lapak = [
  ('Lapak Hijau Karawang', '0,8 km', '4,9', 'Kardus Rp 2.500 · PET Rp 4.000'),
  ('Pengepul Jaya', '1,6 km', '4,8', 'Besi Rp 5.400 · Tembaga Rp 92.000'),
  ('Barokah Jaya Mandiri', '2,3 km', '4,6', 'Kardus Rp 2.300 · Kain Rp 900'),
];

class _LapakOption extends StatelessWidget {
  final (String, String, String, String) data;
  final bool selected;
  final VoidCallback onTap;
  const _LapakOption(
      {required this.data, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      color: selected ? AppColors.merk50 : AppColors.putih,
      borderColor: selected ? AppColors.merk500 : AppColors.slate200,
      borderWidth: selected ? 1.5 : 1,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Radio(selected),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(data.$1, style: T.bodyBold)),
                    const SizedBox(width: 4),
                    const VerifiedBadge(),
                  ],
                ),
                const SizedBox(height: 4),
                _JarakRating(data.$2, data.$3),
                const SizedBox(height: 4),
                Text(data.$4, style: T.s.copyWith(color: AppColors.nilai700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  final bool on;
  const _Radio(this.on);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: on ? AppColors.merk600 : AppColors.slate300,
            width: on ? 6 : 1.5),
        color: AppColors.putih,
      ),
    );
  }
}

class _JarakRating extends StatelessWidget {
  final String jarak;
  final String rating;
  const _JarakRating(this.jarak, this.rating);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(LucideIcons.mapPin, size: 13, color: AppColors.slate500),
        const SizedBox(width: 3),
        Text(jarak, style: T.s),
        const SizedBox(width: 10),
        const Icon(LucideIcons.star, size: 13, color: AppColors.nilai500),
        const SizedBox(width: 3),
        Text(rating, style: T.s),
      ],
    );
  }
}

class _Segmented extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onChanged;
  const _Segmented(
      {required this.items, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColors.slate100, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selected ? AppColors.putih : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: i == selected
                        ? const [
                            BoxShadow(
                                color: Color(0x140F172A),
                                blurRadius: 3,
                                offset: Offset(0, 1))
                          ]
                        : null,
                  ),
                  child: Text(items[i],
                      style: T.label.copyWith(
                          color: i == selected
                              ? AppColors.slate900
                              : AppColors.slate500)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═════════════════════════ Langkah 2 — Barang ═════════════════════════

class Ajukan2Screen extends StatefulWidget {
  const Ajukan2Screen({super.key});

  @override
  State<Ajukan2Screen> createState() => _Ajukan2State();
}

class _Ajukan2State extends State<Ajukan2Screen> {
  int _kategori = 0;
  final _qty = <String, int>{'Kardus': 10, 'Koran': 5, 'HVS / Buku': 0};

  int get _totalKg => _qty.values.fold(0, (a, b) => a + b);
  int get _estimasi =>
      _barang.fold(0, (a, b) => a + (_qty[b.$2] ?? 0) * b.$3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Ajukan Penjemputan', 'Langkah 2 dari 3'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const StepIndicator(current: 2, labels: _langkah),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.merk50,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(LucideIcons.store,
                    size: 16, color: AppColors.merk700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Lapak Hijau Karawang · 0,8 km',
                      style: T.label.copyWith(color: AppColors.merk800)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text('Ganti',
                      style: T.label.copyWith(color: AppColors.merk700)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilterChips(
            items: const ['Kertas', 'Plastik', 'Logam', 'Kaca', 'Kain'],
            selected: _kategori,
            onSelected: (i) => setState(() => _kategori = i),
          ),
          const SizedBox(height: 12),
          for (final b in _barang) ...[
            _BarangRow(
              emoji: b.$1,
              name: b.$2,
              price: b.$3,
              qty: _qty[b.$2]!,
              onChanged: (v) => setState(() => _qty[b.$2] = v),
            ),
            const SizedBox(height: 12),
          ],
          const InfoBox(
            icon: LucideIcons.info,
            text: 'Harga dikunci saat permintaan dikirim. Berat final '
                'mengikuti hasil timbang di tempat.',
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estimasi · $_totalKg kg', style: T.s),
                  Text(rupiah(_estimasi),
                      style: T.l.copyWith(color: AppColors.nilai700)),
                ],
              ),
            ),
            PrimaryButton(
              label: 'Lanjut',
              expand: false,
              onTap: () => Navigator.pushNamed(context, R.a3),
            ),
          ],
        ),
      ),
    );
  }
}

const _barang = [
  ('📄', 'Kardus', 2500),
  ('📰', 'Koran', 2700),
  ('📚', 'HVS / Buku', 3200),
];

/// Format "Rp 38.500".
String rupiah(int v) {
  final s = v.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}

class _BarangRow extends StatelessWidget {
  final String emoji;
  final String name;
  final int price;
  final int qty;
  final ValueChanged<int> onChanged;
  const _BarangRow({
    required this.emoji,
    required this.name,
    required this.price,
    required this.qty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final active = qty > 0;
    return AppCard(
      borderColor: active ? AppColors.merk200 : AppColors.slate200,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          EmojiTile(emoji),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: T.bodyBold),
                const SizedBox(height: 2),
                Text('${rupiah(price)} /kg',
                    style: T.s.copyWith(color: AppColors.nilai700)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.putih,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                _StepBtn('−', onTap: () => onChanged(qty > 0 ? qty - 1 : 0)),
                SizedBox(
                  width: 52,
                  height: 34,
                  child: Center(
                    child: Text('$qty kg',
                        style: T.label.copyWith(color: AppColors.slate700)),
                  ),
                ),
                _StepBtn('+', filled: active, onTap: () => onChanged(qty + 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final String text;
  final bool filled;
  final VoidCallback onTap;
  const _StepBtn(this.text, {this.filled = false, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 34,
        alignment: Alignment.center,
        color: filled ? AppColors.merk600 : Colors.transparent,
        child: Text(text,
            style: T.bodyBold.copyWith(
                color: filled ? AppColors.putih : AppColors.slate700)),
      ),
    );
  }
}

// ═════════════════════ Langkah 3 — Alamat & Jadwal ═════════════════════

class Ajukan3Screen extends StatefulWidget {
  const Ajukan3Screen({super.key});

  @override
  State<Ajukan3Screen> createState() => _Ajukan3State();
}

class _Ajukan3State extends State<Ajukan3Screen> {
  int _hari = 2;
  int _jam = 1;

  static const _hariList = [
    ('Kam', '2'),
    ('Jum', '3'),
    ('Sab', '4'),
    ('Min', '5'),
    ('Sen', '6'),
  ];
  static const _jamList = [
    '07.00–09.00',
    '09.00–11.00',
    '13.00–15.00',
    '15.00–17.00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Ajukan Penjemputan', 'Langkah 3 dari 3'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const StepIndicator(current: 3, labels: _langkah),
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.mapPin,
                        size: 18, color: AppColors.merk600),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Alamat jemput', style: T.bodyBold)),
                    Text('Ubah',
                        style: T.label.copyWith(color: AppColors.merk700)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Jl. Tuparev No. 21, RT 03/RW 05, dekat Masjid Al-Ikhlas, '
                  'Adiarsa Timur, Karawang Barat',
                  style: T.s.copyWith(color: AppColors.slate600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const FieldLabel('Tanggal jemput'),
          const SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < _hariList.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _hari = i),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: i == _hari ? AppColors.merk600 : AppColors.putih,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: i == _hari
                                ? AppColors.merk600
                                : AppColors.slate200),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_hariList[i].$1,
                              style: T.s.copyWith(
                                  color: i == _hari
                                      ? AppColors.merk100
                                      : AppColors.slate500)),
                          Text(_hariList[i].$2,
                              style: T.m.copyWith(
                                  color: i == _hari
                                      ? AppColors.putih
                                      : AppColors.slate900)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          const FieldLabel('Rentang waktu'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < _jamList.length; i++)
                GestureDetector(
                  onTap: () => setState(() => _jam = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: i == _jam ? AppColors.merk600 : AppColors.putih,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          color:
                              i == _jam ? AppColors.merk600 : AppColors.slate200),
                    ),
                    child: Text(_jamList[i],
                        style: T.label.copyWith(
                            color: i == _jam
                                ? AppColors.putih
                                : AppColors.slate600)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const FieldLabel('Catatan untuk pengepul (opsional)'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'Contoh: barang di garasi, bel rusak'),
          const SizedBox(height: 16),
          CustomPaint(
            painter: DashedBorderPainter(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const IconBox(LucideIcons.upload,
                      size: 40,
                      iconSize: 18,
                      bg: AppColors.slate50,
                      fg: AppColors.slate600,
                      radius: 12),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Foto barang (opsional)', style: T.bodyBold),
                        const SizedBox(height: 2),
                        Text(
                            'JPG/PNG maks. 2 MB, bantu pengepul menyiapkan armada',
                            style: T.s),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lapak Hijau Karawang · 15 kg', style: T.s),
                Text('± Rp 38.500',
                    style: T.bodyBold.copyWith(color: AppColors.nilai700)),
              ],
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              label: 'Kirim Permintaan',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, R.wDash, (r) => r.settings.name == R.beranda),
            ),
          ],
        ),
      ),
    );
  }
}

/// Border putus-putus radius 16 (kotak unggah foto).
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  DashedBorderPainter({this.color = AppColors.slate300, this.radius = 16});

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
        Offset.zero & size, Radius.circular(radius));
    canvas.drawRRect(rrect, Paint()..color = AppColors.putih);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 5), paint);
        d += 9;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

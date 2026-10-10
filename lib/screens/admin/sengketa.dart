import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';

class SengketaScreen extends StatefulWidget {
  const SengketaScreen({super.key});

  @override
  State<SengketaScreen> createState() => _SengketaScreenState();
}

class _SengketaScreenState extends State<SengketaScreen> {
  int _keputusan = 0;
  bool _sanksi = true;

  static const _opsi = [
    ('Pakai harga awal', 'Total dihitung ulang dengan harga terkunci'),
    ('Pakai hasil timbang', 'Pertahankan nilai yang dibayar di lokasi'),
    ('Kompromi', 'Selisih ditanggung bersama 50:50'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('SKT-00001', 'Atas permintaan RSK-00098'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Aduan warga
          AppCard(
            color: AppColors.rose50,
            borderColor: AppColors.rose100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.triangleAlert,
                        size: 16, color: AppColors.rose600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Harga diturunkan sepihak di lokasi',
                          style: T.bodyBold.copyWith(color: AppColors.rose700)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '“Di aplikasi harga yang dikunci sudah jelas, tapi saat di '
                  'rumah pengepul hanya mau membayar sekitar 75% dari harga '
                  'itu. Barang saya kering.”',
                  style: T.s.copyWith(
                      color: AppColors.slate700, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 6),
                Text('— Siti Aminah (warga)',
                    style: T.xs.copyWith(color: AppColors.rose600)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Catatan pengepul
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Catatan pengepul · Rongsok Berkah', style: T.s),
                const SizedBox(height: 4),
                Text('“Barang agak basah, harga saya sesuaikan.”',
                    style: T.bodyBold),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Tabel harga
          AppCard(
            child: Column(
              children: [
                const _Baris('Item', 'Dikunci', 'Di lokasi', header: true),
                const SizedBox(height: 10),
                const Sep(),
                const SizedBox(height: 10),
                const _Baris('Kardus · 9,4 kg', 'Rp 2.400', 'Rp 1.800'),
                const SizedBox(height: 10),
                const _Baris('Botol PET · 3,1 kg', 'Rp 4.000', 'Rp 3.000'),
                const SizedBox(height: 10),
                const Sep(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Selisih ke warga',
                        style: T.s.copyWith(color: AppColors.slate600)),
                    Text('Rp 8.740',
                        style: T.m.copyWith(color: AppColors.rose600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const FieldLabel('Keputusan'),
          const SizedBox(height: 8),
          for (int i = 0; i < _opsi.length; i++) ...[
            AppCard(
              onTap: () => setState(() => _keputusan = i),
              color: i == _keputusan ? AppColors.merk50 : AppColors.putih,
              borderColor:
                  i == _keputusan ? AppColors.merk500 : AppColors.slate200,
              borderWidth: i == _keputusan ? 1.5 : 1,
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.putih,
                      border: Border.all(
                          color: i == _keputusan
                              ? AppColors.merk600
                              : AppColors.slate300,
                          width: i == _keputusan ? 6 : 1.5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_opsi[i].$1, style: T.bodyBold),
                        Text(_opsi[i].$2, style: T.s),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => setState(() => _sanksi = !_sanksi),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: _sanksi ? AppColors.rose600 : AppColors.putih,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color:
                              _sanksi ? AppColors.rose600 : AppColors.slate300,
                          width: 1.5),
                    ),
                    child: _sanksi
                        ? const Icon(LucideIcons.check,
                            size: 12, color: AppColors.putih)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text('Beri sanksi peringatan ke pengepul',
                      style: T.s.copyWith(color: AppColors.slate700)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              label: 'Putuskan Sengketa',
              onTap: () => Navigator.maybePop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _Baris extends StatelessWidget {
  final String item;
  final String dikunci;
  final String lokasi;
  final bool header;
  const _Baris(this.item, this.dikunci, this.lokasi, {this.header = false});

  @override
  Widget build(BuildContext context) {
    final base = header ? T.xs.copyWith(color: AppColors.slate500) : T.bodyBold;
    return Row(
      children: [
        Expanded(flex: 5, child: Text(item, style: base)),
        Expanded(
          flex: 3,
          child: Text(dikunci,
              textAlign: TextAlign.right,
              style: header ? base : T.s.copyWith(color: AppColors.slate600)),
        ),
        Expanded(
          flex: 3,
          child: Text(lokasi,
              textAlign: TextAlign.right,
              style: header
                  ? base
                  : T.label.copyWith(color: AppColors.rose600)),
        ),
      ],
    );
  }
}

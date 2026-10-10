import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class PengepulMasuk extends StatefulWidget {
  const PengepulMasuk({super.key});

  @override
  State<PengepulMasuk> createState() => _PengepulMasukState();
}

class _PengepulMasukState extends State<PengepulMasuk> {
  int _tab = 0;

  static const _tabs = [('Baru', 3), ('Jadwal', 2), ('Jemput', 1), ('Riwayat', 0)];

  static const _data = <List<(String, String, Tone, String, String, String, String)>>[
    [
      ('RSK-00133', 'Menunggu Respons', Tone.orange, 'Siti Aminah · 0,8 km',
          'Sab, 4 Okt · 09.00–11.00', '3 jenis · ±18 kg', '± Rp 42.600'),
      ('RSK-00132', 'Menunggu Respons', Tone.orange, 'Budi Santoso · 1,2 km',
          'Min, 5 Okt · 07.00–09.00', 'Besi, Aluminium · ±25 kg',
          '± Rp 131.000'),
      ('RSK-00130', 'Menunggu Respons', Tone.orange, 'Dewi Lestari · 2,1 km',
          'Sen, 6 Okt · 13.00–15.00', 'Kain perca · ±12 kg', '± Rp 10.800'),
    ],
    [
      ('RSK-00129', 'Dijadwalkan', Tone.sky, 'Rina Wati · 1,4 km',
          'Sab, 4 Okt · 13.00–15.00', '2 jenis · ±9 kg', '± Rp 24.300'),
      ('RSK-00128', 'Dijadwalkan', Tone.sky, 'Agus Salim · 0,5 km',
          'Min, 5 Okt · 09.00–11.00', 'Kardus · ±20 kg', '± Rp 50.000'),
    ],
    [
      ('RSK-00131', 'Sedang Dijemput', Tone.violet, 'Siti Aminah · 0,8 km',
          'Hari ini · 09.00–11.00', '3 jenis · ±18 kg', '± Rp 42.600'),
    ],
    [
      ('RSK-00127', 'Selesai', Tone.merk, 'Siti Aminah · 0,8 km',
          'Kam, 2 Okt · ditimbang 10.12', '2 jenis · 11,4 kg', 'Rp 32.700'),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Permintaan Masuk', 'Kelola penjemputan'),
      bottomNavigationBar: pengepulNav(context, 1),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                for (int i = 0; i < _tabs.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tab = i),
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: i == _tab ? AppColors.putih : Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: i == _tab
                              ? const [
                                  BoxShadow(
                                      color: Color(0x140F172A),
                                      blurRadius: 3,
                                      offset: Offset(0, 1))
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_tabs[i].$1,
                                style: T.label.copyWith(
                                    color: i == _tab
                                        ? AppColors.slate900
                                        : AppColors.slate500)),
                            if (_tabs[i].$2 > 0) ...[
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: i == _tab
                                      ? AppColors.merk600
                                      : AppColors.slate200,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text('${_tabs[i].$2}',
                                    style: T.xs.copyWith(
                                        color: i == _tab
                                            ? AppColors.putih
                                            : AppColors.slate600)),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          for (final r in _data[_tab]) ...[
            RequestCard(
              code: r.$1,
              status: r.$2,
              tone: r.$3,
              title: r.$4,
              schedule: r.$5,
              summary: r.$6,
              amount: r.$7,
              onTap: () => Navigator.pushNamed(context, R.timbang),
            ),
            const SizedBox(height: 12),
          ],
          const InfoBox(
            icon: LucideIcons.clock,
            text: 'Respons dalam 24 jam menjaga skor tingkat penerimaanmu.',
            bg: AppColors.sky50,
            fg: AppColors.sky700,
          ),
        ],
      ),
    );
  }
}

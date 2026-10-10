import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class DompetScreen extends StatelessWidget {
  const DompetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dompet',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      bottomNavigationBar: pengepulNav(context, 4),
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
                Text('Saldo tersedia',
                    style: TextStyle(color: Color(0xFFD1FAE5))),
                SizedBox(height: 6),
                Text('Rp 1.250.000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Isi Saldo',
                  icon: Icons.add,
                  onTap: () => _topup(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlineButton(
                  label: 'Tarik',
                  onTap: () => _topup(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader('Riwayat transaksi'),
          const SizedBox(height: 12),
          for (final t in _riwayat)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          t.$4 ? AppColors.emeraldLight : AppColors.amberLight,
                      child: Icon(
                          t.$4 ? Icons.south_west : Icons.north_east,
                          size: 18,
                          color: t.$4 ? AppColors.emerald : AppColors.amber),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.$1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          Text(t.$2,
                              style: const TextStyle(
                                  color: AppColors.inkMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(t.$3,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: t.$4 ? AppColors.emerald : AppColors.ink)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _topup(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur dummy — UI prototype')),
    );
  }
}

const _riwayat = [
  ('Pembayaran ke Andhika', '10 Okt • 14.20', '- Rp 40.000', false),
  ('Isi saldo', '9 Okt • 09.00', '+ Rp 500.000', true),
  ('Pembayaran ke Sari', '8 Okt • 16.45', '- Rp 32.000', false),
];

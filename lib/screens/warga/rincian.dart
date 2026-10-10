import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

class RincianScreen extends StatelessWidget {
  const RincianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Permintaan',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      bottomNavigationBar: wargaNav(context, 2),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          // Status
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.amberLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_shipping, color: AppColors.amber, size: 30),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Sedang dijemput',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text('Pak Budi dalam perjalanan',
                        style: TextStyle(color: AppColors.inkMuted, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader('Barang'),
          const SizedBox(height: 12),
          for (final b in _barang)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Text(b.$1, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(b.$2,
                            style: const TextStyle(fontWeight: FontWeight.w700))),
                    Text(b.$3,
                        style:
                            const TextStyle(color: AppColors.inkMuted, fontSize: 13)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: [
                _baris('Berat total', '13 kg'),
                const Divider(height: 24, color: AppColors.line),
                _baris('Estimasi nilai', 'Rp 40.000', tebal: true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Konfirmasi & Terima Tunai',
            icon: Icons.payments_outlined,
            onTap: () => Navigator.pushNamed(context, R.dampak),
          ),
        ],
      ),
    );
  }

  Widget _baris(String k, String v, {bool tebal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(k, style: const TextStyle(color: AppColors.inkMuted)),
        Text(v,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: tebal ? 18 : 14,
                color: tebal ? AppColors.emerald : AppColors.ink)),
      ],
    );
  }
}

const _barang = [
  ('🧴', 'Botol plastik PET', '5 kg'),
  ('📦', 'Kardus bekas', '8 kg'),
];

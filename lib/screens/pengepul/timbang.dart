import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class TimbangScreen extends StatelessWidget {
  const TimbangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Timbang Barang'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.emeraldLight,
                  child: Text('👤'),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Andhika',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      Text('Jl. Melati No. 10 • 0.6 km',
                          style: TextStyle(
                              color: AppColors.inkMuted, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader('Hasil timbang'),
          const SizedBox(height: 12),
          for (final b in _barang)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Text(b.$1, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(b.$2,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          Text(b.$3,
                              style: const TextStyle(
                                  color: AppColors.inkMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 72,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'kg',
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColors.line),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.emerald, width: 1.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.emeraldLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Total dibayar',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                Text('Rp 40.000',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: AppColors.emeraldDark)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Kirim Hasil ke Warga',
            icon: Icons.send_rounded,
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, R.pDash, (r) => false),
          ),
          const SizedBox(height: 10),
          OutlineButton(
            label: 'Batal',
            color: AppColors.inkMuted,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

const _barang = [
  ('🧴', 'Botol plastik PET', 'Rp 4.000 / kg'),
  ('📦', 'Kardus bekas', 'Rp 2.500 / kg'),
];

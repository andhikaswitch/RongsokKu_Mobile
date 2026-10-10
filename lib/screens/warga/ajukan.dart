import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

/// Indikator langkah 1-2-3.
class _Steps extends StatelessWidget {
  final int current; // 1..3
  const _Steps(this.current);
  @override
  Widget build(BuildContext context) {
    const labels = ['Lokasi', 'Barang', 'Konfirmasi'];
    return Row(
      children: [
        for (int i = 0; i < 3; i++) ...[
          Column(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor:
                    (i + 1) <= current ? AppColors.emerald : AppColors.line,
                child: Text('${i + 1}',
                    style: TextStyle(
                        color: (i + 1) <= current
                            ? Colors.white
                            : AppColors.inkMuted,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 4),
              Text(labels[i],
                  style: const TextStyle(fontSize: 11, color: AppColors.inkMuted)),
            ],
          ),
          if (i < 2)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: 18),
                color: (i + 2) <= current ? AppColors.emerald : AppColors.line,
              ),
            ),
        ],
      ],
    );
  }
}

class Ajukan1Screen extends StatelessWidget {
  const Ajukan1Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Ajukan Penjemputan'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _Steps(1),
          const SizedBox(height: 24),
          const FieldLabel('Alamat penjemputan'),
          const SizedBox(height: 8),
          const AppTextField(
              hint: 'Jl. Melati No. 10, Cikampek',
              icon: Icons.location_on_outlined),
          const SizedBox(height: 16),
          const FieldLabel('Pengepul tujuan'),
          const SizedBox(height: 8),
          AppCard(
            onTap: () => Navigator.pushNamed(context, R.cari),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: const [
                Text('♻', style: TextStyle(fontSize: 22)),
                SizedBox(width: 12),
                Expanded(
                  child: Text('Bank Sampah Melati',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Icon(Icons.chevron_right, color: AppColors.inkMuted),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const FieldLabel('Jadwal'),
          const SizedBox(height: 8),
          Row(
            children: const [
              Expanded(
                  child: AppTextField(
                      hint: 'Hari ini', icon: Icons.calendar_today_outlined)),
              SizedBox(width: 12),
              Expanded(
                  child: AppTextField(
                      hint: '13.00–15.00', icon: Icons.schedule)),
            ],
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Lanjut ke Barang',
            onTap: () => Navigator.pushNamed(context, R.a2),
          ),
        ],
      ),
    );
  }
}

class Ajukan2Screen extends StatelessWidget {
  const Ajukan2Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Ajukan Penjemputan'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _Steps(2),
          const SizedBox(height: 24),
          const FieldLabel('Pilih jenis barang'),
          const SizedBox(height: 12),
          for (final b in _barang)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Text(b.$1, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(b.$2,
                              style: const TextStyle(fontWeight: FontWeight.w700)),
                          Text(b.$3,
                              style: const TextStyle(
                                  color: AppColors.inkMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                    const _Counter(),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Lanjut',
            onTap: () => Navigator.pushNamed(context, R.a3),
          ),
        ],
      ),
    );
  }
}

const _barang = [
  ('🧴', 'Botol plastik PET', 'Rp 4.000 / kg'),
  ('📦', 'Kardus bekas', 'Rp 2.500 / kg'),
  ('🥫', 'Kaleng alumunium', 'Rp 12.000 / kg'),
];

class _Counter extends StatefulWidget {
  const _Counter();
  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int n = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RoundBtn(Icons.remove, () => setState(() => n = n > 0 ? n - 1 : 0)),
        SizedBox(
          width: 36,
          child: Text('$n kg',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ),
        _RoundBtn(Icons.add, () => setState(() => n++)),
      ],
    );
  }
}

class _RoundBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundBtn(this.icon, this.onTap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.emeraldLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.emeraldDark),
      ),
    );
  }
}

class Ajukan3Screen extends StatelessWidget {
  const Ajukan3Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Ajukan Penjemputan'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _Steps(3),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _RingkasBaris('Pengepul', 'Bank Sampah Melati'),
                Divider(height: 24, color: AppColors.line),
                _RingkasBaris('Alamat', 'Jl. Melati No. 10'),
                Divider(height: 24, color: AppColors.line),
                _RingkasBaris('Jadwal', 'Hari ini, 13.00–15.00'),
                Divider(height: 24, color: AppColors.line),
                _RingkasBaris('Barang', 'Botol 5kg, Kardus 8kg'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.emeraldLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Estimasi diterima',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                Text('± Rp 40.000',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.emeraldDark,
                        fontSize: 18)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Kirim Permintaan',
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => _SuksesDialog(
                  onClose: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(R.wDash, (r) => false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RingkasBaris extends StatelessWidget {
  final String label;
  final String value;
  const _RingkasBaris(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(color: AppColors.inkMuted))),
        const SizedBox(width: 12),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class _SuksesDialog extends StatelessWidget {
  final VoidCallback onClose;
  const _SuksesDialog({required this.onClose});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.emeraldLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  color: AppColors.emerald, size: 36),
            ),
            const SizedBox(height: 16),
            const Text('Permintaan terkirim!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            const Text('Pengepul akan segera mengonfirmasi penjemputan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.inkMuted)),
            const SizedBox(height: 20),
            PrimaryButton(label: 'Selesai', onTap: onClose),
          ],
        ),
      ),
    );
  }
}

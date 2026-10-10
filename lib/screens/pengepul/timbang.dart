import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../warga/ajukan.dart' show rupiah;

class TimbangScreen extends StatefulWidget {
  const TimbangScreen({super.key});

  @override
  State<TimbangScreen> createState() => _TimbangScreenState();
}

class _TimbangScreenState extends State<TimbangScreen> {
  static const _saldo = 148500;
  static const _items = [
    ('Kardus', 10, 2500, '11,2'),
    ('Koran', 5, 2700, '4,6'),
    ('HVS / Buku', 3, 3200, '3,0'),
  ];

  late final _ctrl = [
    for (final it in _items) TextEditingController(text: it.$4)
  ];

  @override
  void dispose() {
    for (final c in _ctrl) {
      c.dispose();
    }
    super.dispose();
  }

  double _kg(int i) =>
      double.tryParse(_ctrl[i].text.replaceAll(',', '.')) ?? 0;

  int get _total => [
        for (int i = 0; i < _items.length; i++) (_kg(i) * _items[i].$3).round()
      ].fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    final total = _total;
    final komisi = (total * 0.05).round();
    return Scaffold(
      appBar: subBar('RSK-00131', 'Siti Aminah · Adiarsa Timur'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu warga
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const InitialAvatar('SA',
                        size: 40,
                        circle: true,
                        bg: AppColors.nilai100,
                        fg: AppColors.nilai700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Siti Aminah', style: T.bodyBold),
                          Text('Jl. Tuparev No. 21', style: T.s),
                        ],
                      ),
                    ),
                    const StatusPill('Sedang Dijemput', tone: Tone.violet),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'WhatsApp',
                        icon: LucideIcons.messageCircle,
                        color: AppColors.merk50,
                        fg: AppColors.merk700,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Buka Peta',
                        icon: LucideIcons.mapPin,
                        color: AppColors.merk50,
                        fg: AppColors.merk700,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Input hasil timbang
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const IconBox(LucideIcons.scale,
                        bg: AppColors.violet50, fg: AppColors.violet600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Input hasil timbang', style: T.bodyBold),
                          Text('Harga per kg terkunci sejak permintaan dikirim',
                              style: T.s),
                        ],
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < _items.length; i++) ...[
                  const SizedBox(height: 12),
                  if (i > 0) ...[const Sep(), const SizedBox(height: 12)],
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_items[i].$1, style: T.bodyBold),
                            Text(
                                'est. ${_items[i].$2} kg · ${rupiah(_items[i].$3)}/kg',
                                style: T.s),
                          ],
                        ),
                      ),
                      _KgInput(
                        controller: _ctrl[i],
                        onChanged: () => setState(() {}),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Ringkasan
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: [
                _SumRow('Total dibayar ke warga', rupiah(total),
                    style: T.bodyBold),
                const SizedBox(height: 8),
                _SumRow('Komisi platform (5%)', '− ${rupiah(komisi)}',
                    style: T.s.copyWith(color: AppColors.rose600)),
                const SizedBox(height: 8),
                _SumRow('Saldo setelah selesai', rupiah(_saldo - komisi),
                    style: T.s.copyWith(color: AppColors.slate700)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Row(
          children: [
            Expanded(
              child: OutlineButton(
                  label: 'Batal', onTap: () => Navigator.maybePop(context)),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: PrimaryButton(
                label: 'Kirim Hasil ke Warga',
                onTap: () => Navigator.maybePop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SumRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle style;
  const _SumRow(this.label, this.value, {required this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: T.s.copyWith(color: AppColors.slate600)),
        Text(value, style: style),
      ],
    );
  }
}

/// Kotak input berat (angka + "kg"), 84×40.
class _KgInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  const _KgInput({required this.controller, required this.onChanged});

  @override
  State<_KgInput> createState() => _KgInputState();
}

class _KgInputState extends State<_KgInput> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final on = _focus.hasFocus;
    return Container(
      width: 88,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.putih,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: on ? AppColors.merk500 : AppColors.slate200,
            width: on ? 1.5 : 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              onChanged: (_) => widget.onChanged(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.right,
              style: T.bodyBold,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero),
            ),
          ),
          const SizedBox(width: 4),
          Text('kg', style: T.s.copyWith(color: AppColors.slate400)),
        ],
      ),
    );
  }
}

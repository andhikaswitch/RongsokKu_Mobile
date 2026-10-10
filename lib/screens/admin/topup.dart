import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

enum _St { menunggu, disetujui, ditolak }

class _Topup {
  final String kode, lapak, inisial, waktu, nominal, pengirim, catatan;
  _St status;
  _Topup(this.kode, this.lapak, this.inisial, this.waktu, this.nominal,
      this.pengirim, this.status,
      [this.catatan = '']);
}

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  int _filter = 0;

  final _data = [
    _Topup('TOP-00042', 'Lapak Hijau Karawang', 'HK', 'Hari ini, 09.14',
        'Rp 200.000', 'BRI · a.n. Darto Wijaya', _St.menunggu),
    _Topup('TOP-00041', 'Lapak Hijau Karawang', 'HK', '28 Sep, 15.02',
        'Rp 200.000', 'BRI · a.n. Darto Wijaya', _St.disetujui),
    _Topup('TOP-00040', 'Barokah Jaya Mandiri', 'BJ', '27 Sep, 11.40',
        'Rp 50.000', 'Mandiri · a.n. Hj. Siti Barokah', _St.ditolak,
        'Nominal di bukti transfer tidak sesuai'),
    _Topup('TOP-00039', 'Pengepul Jaya', 'PJ', '26 Sep, 08.21',
        'Rp 150.000', 'BCA · a.n. Joko Prasetyo', _St.disetujui),
  ];

  int _count(_St s) => _data.where((t) => t.status == s).length;

  void _putuskan(_Topup t, _St hasil) {
    setState(() => t.status = hasil);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.slate900,
      content: Text(hasil == _St.disetujui
          ? '${t.kode} disetujui · saldo ${t.lapak} bertambah ${t.nominal}'
          : '${t.kode} ditolak · pengepul akan diberi tahu'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final status = _St.values[_filter];
    final shown = _data.where((t) => t.status == status).toList();
    return Scaffold(
      appBar: panelBar('Verifikasi Top-up', 'Bukti transfer dari pengepul'),
      bottomNavigationBar: adminNav(context, 2),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilterChips(
            items: [
              'Menunggu (${_count(_St.menunggu)})',
              'Disetujui (${_count(_St.disetujui)})',
              'Ditolak (${_count(_St.ditolak)})',
            ],
            selected: _filter,
            onSelected: (i) => setState(() => _filter = i),
          ),
          const SizedBox(height: 12),
          if (status == _St.menunggu) ...[
            const InfoBox(
              icon: LucideIcons.info,
              text: 'Cocokkan nominal & nama pengirim dengan mutasi rekening '
                  'RongsokKu sebelum menyetujui.',
              bg: AppColors.sky50,
              fg: AppColors.sky700,
            ),
            const SizedBox(height: 12),
          ],
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  const IconBox(LucideIcons.circleCheck,
                      size: 48, iconSize: 24, radius: 14),
                  const SizedBox(height: 12),
                  Text('Tidak ada top-up di sini', style: T.bodyBold),
                  Text('Semua permintaan sudah ditangani.', style: T.s),
                ],
              ),
            ),
          for (final t in shown) ...[
            status == _St.menunggu
                ? _PendingCard(
                    t,
                    onTolak: () => _putuskan(t, _St.ditolak),
                    onSetujui: () => _putuskan(t, _St.disetujui),
                  )
                : _HistoryCard(t),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _PendingCard extends StatelessWidget {
  final _Topup t;
  final VoidCallback onTolak;
  final VoidCallback onSetujui;
  const _PendingCard(this.t, {required this.onTolak, required this.onSetujui});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InitialAvatar(t.inisial, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.lapak, style: T.bodyBold),
                    Text('${t.kode} · ${t.waktu}', style: T.s),
                  ],
                ),
              ),
              const StatusPill('Menunggu', tone: Tone.orange),
            ],
          ),
          const SizedBox(height: 14),
          Text('Nominal top-up', style: T.s),
          Text(t.nominal, style: T.xl.copyWith(color: AppColors.nilai700)),
          const SizedBox(height: 10),
          const Sep(),
          const _KV('Rekening tujuan', 'BCA 123 456 7890 · RongsokKu'),
          _KV('Pengirim', t.pengirim),
          const _KV('Saldo sebelum', 'Rp 148.500'),
          const SizedBox(height: 6),
          // Bukti transfer
          Container(
            height: 132,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.receipt,
                    size: 28, color: AppColors.slate400),
                const SizedBox(height: 6),
                Text('bukti-transfer.jpg · 412 KB',
                    style: T.s.copyWith(color: AppColors.slate600)),
                const SizedBox(height: 2),
                Text('Ketuk untuk memperbesar',
                    style: T.xs.copyWith(color: AppColors.merk700)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlineButton(
                    label: 'Tolak', color: AppColors.rose600, onTap: onTolak),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(label: 'Setujui', onTap: onSetujui),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final _Topup t;
  const _HistoryCard(this.t);

  @override
  Widget build(BuildContext context) {
    final ok = t.status == _St.disetujui;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBox(ok ? LucideIcons.wallet : LucideIcons.x,
                  size: 36,
                  bg: ok ? AppColors.merk50 : AppColors.rose50,
                  fg: ok ? AppColors.merk700 : AppColors.rose600),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.lapak, style: T.bodyBold),
                    Text('${t.kode} · ${t.waktu}', style: T.s),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(t.nominal,
                      style: T.bodyBold.copyWith(
                          color: ok ? AppColors.merk600 : AppColors.slate400,
                          decoration:
                              ok ? null : TextDecoration.lineThrough)),
                  Text(ok ? 'Disetujui' : 'Ditolak',
                      style: T.xs.copyWith(
                          color: ok ? AppColors.merk700 : AppColors.rose600)),
                ],
              ),
            ],
          ),
          if (t.catatan.isNotEmpty) ...[
            const SizedBox(height: 10),
            InfoBox(
              icon: LucideIcons.circleAlert,
              text: t.catatan,
              bg: AppColors.rose50,
              fg: AppColors.rose600,
            ),
          ],
        ],
      ),
    );
  }
}

class _KV extends StatelessWidget {
  final String k;
  final String v;
  const _KV(this.k, this.v);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Text(k, style: T.s),
          const SizedBox(width: 12),
          Expanded(child: Text(v, textAlign: TextAlign.right, style: T.label)),
        ],
      ),
    );
  }
}

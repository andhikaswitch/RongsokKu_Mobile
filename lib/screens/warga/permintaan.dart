import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

// CRUD Anggota 4 — TRANSAKSI: Permintaan Penjemputan
//   Create : Ajukan penjemputan (ajukan.dart, 3 langkah)
//   Read   : Daftar permintaan (tab Aktif/Selesai/Dibatalkan) · Detail
//   Update : Edit barang, jadwal & catatan (selama belum dijemput)
//   Delete : Batalkan permintaan · Hapus dari riwayat

/// Satu barang dalam permintaan.
class BarangData {
  final String emoji, nama;
  final int harga;
  int kg;
  BarangData(this.emoji, this.nama, this.harga, this.kg);
  BarangData copy() => BarangData(emoji, nama, harga, kg);
}

enum StatusP { menunggu, dijadwalkan, ditimbang, selesai, dibatalkan }

/// Data permintaan penjemputan (hanya untuk tampilan).
class PermintaanData {
  final String kode, lapak, alamat;
  StatusP status;
  int hari; // indeks DayPicker
  int jam; // indeks [jamList]
  String catatan, alasan;
  List<BarangData> barang;

  PermintaanData({
    required this.kode,
    required this.lapak,
    required this.status,
    required this.hari,
    required this.jam,
    required this.barang,
    this.alamat =
        'Jl. Tuparev No. 21, RT 03/RW 05, Adiarsa Timur, Karawang Barat',
    this.catatan = '',
    this.alasan = '',
  });

  int get kg => barang.fold(0, (a, b) => a + b.kg);
  int get nilai => barang.fold(0, (a, b) => a + b.kg * b.harga);
  int get jenis => barang.where((b) => b.kg > 0).length;
  String get jadwal => '${DayPicker.label(hari)} · ${jamList[jam]}';
  bool get bisaDiubah =>
      status == StatusP.menunggu || status == StatusP.dijadwalkan;

  PermintaanData copy() => PermintaanData(
        kode: kode,
        lapak: lapak,
        status: status,
        hari: hari,
        jam: jam,
        barang: [for (final b in barang) b.copy()],
        alamat: alamat,
        catatan: catatan,
        alasan: alasan,
      );
}

const jamList = ['07.00–09.00', '09.00–11.00', '13.00–15.00', '15.00–17.00'];

(String, Tone) statusInfo(StatusP s) => switch (s) {
      StatusP.menunggu => ('Menunggu Respons', Tone.orange),
      StatusP.dijadwalkan => ('Dijadwalkan', Tone.sky),
      StatusP.ditimbang => ('Menunggu Konfirmasi', Tone.violet),
      StatusP.selesai => ('Selesai', Tone.merk),
      StatusP.dibatalkan => ('Dibatalkan', Tone.slate),
    };

/// Contoh data permintaan milik Siti Aminah.
List<PermintaanData> contohPermintaan() => [
      PermintaanData(
        kode: 'RSK-00133',
        lapak: 'Lapak Hijau Karawang',
        status: StatusP.menunggu,
        hari: 2,
        jam: 1,
        catatan: 'Barang di garasi samping',
        barang: [
          BarangData('📄', 'Kardus', 2500, 10),
          BarangData('📰', 'Koran', 2700, 5),
          BarangData('📚', 'HVS / Buku', 3200, 3),
        ],
      ),
      PermintaanData(
        kode: 'RSK-00131',
        lapak: 'Lapak Hijau Karawang',
        status: StatusP.dijadwalkan,
        hari: 2,
        jam: 2,
        barang: [
          BarangData('🧴', 'Botol PET', 4000, 4),
          BarangData('📄', 'Kardus', 2500, 6),
        ],
      ),
      PermintaanData(
        kode: 'RSK-00127',
        lapak: 'Pengepul Jaya',
        status: StatusP.ditimbang,
        hari: 0,
        jam: 1,
        barang: [
          BarangData('📄', 'Kardus', 2500, 10),
          BarangData('🧴', 'Botol PET', 4000, 2),
        ],
      ),
      PermintaanData(
        kode: 'RSK-00126',
        lapak: 'Lapak Hijau Karawang',
        status: StatusP.selesai,
        hari: 0,
        jam: 0,
        barang: [BarangData('📄', 'Kardus', 2400, 8)],
      ),
      PermintaanData(
        kode: 'RSK-00124',
        lapak: 'Barokah Jaya Mandiri',
        status: StatusP.dibatalkan,
        hari: 1,
        jam: 3,
        alasan: 'Jadwal bentrok dengan acara keluarga',
        barang: [BarangData('🧺', 'Kain perca', 900, 6)],
      ),
    ];

// ═══════════════════════════ READ: Daftar Permintaan ═══════════════════════════

class PermintaanListScreen extends StatefulWidget {
  const PermintaanListScreen({super.key});

  @override
  State<PermintaanListScreen> createState() => _PermintaanListScreenState();
}

class _PermintaanListScreenState extends State<PermintaanListScreen> {
  int _tab = 0;
  final _data = contohPermintaan();

  List<PermintaanData> get _aktif => _data
      .where((p) =>
          p.status != StatusP.selesai && p.status != StatusP.dibatalkan)
      .toList();
  List<PermintaanData> get _selesai =>
      _data.where((p) => p.status == StatusP.selesai).toList();
  List<PermintaanData> get _batal =>
      _data.where((p) => p.status == StatusP.dibatalkan).toList();

  Future<void> _buka(PermintaanData p) async {
    if (p.status == StatusP.ditimbang) {
      await Navigator.pushNamed(context, R.wRinci);
      return;
    }
    final r = await Navigator.pushNamed(context, R.wPermintaanDetail,
        arguments: p);
    if (!mounted) return;
    if (r == 'hapus') {
      setState(() => _data.remove(p));
      toast(context, '${p.kode} dihapus dari riwayat');
    } else {
      setState(() {}); // status / isi mungkin berubah di layar detail
    }
  }

  Future<void> _hapus(PermintaanData p) async {
    final ok = await confirmDialog(context,
        title: 'Hapus ${p.kode}?',
        message: 'Permintaan yang dibatalkan akan dihapus permanen '
            'dari riwayatmu.');
    if (!ok || !mounted) return;
    setState(() => _data.remove(p));
    toast(context, '${p.kode} dihapus dari riwayat');
  }

  @override
  Widget build(BuildContext context) {
    final lists = [_aktif, _selesai, _batal];
    final shown = lists[_tab];
    return Scaffold(
      appBar: panelBar('Permintaan Saya', 'Riwayat & status penjemputan',
          notif: false),
      bottomNavigationBar: wargaNav(context, 2),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilterChips(
            items: [
              'Aktif (${_aktif.length})',
              'Selesai (${_selesai.length})',
              'Dibatalkan (${_batal.length})',
            ],
            selected: _tab,
            onSelected: (i) => setState(() => _tab = i),
          ),
          const SizedBox(height: 12),
          if (shown.isEmpty)
            EmptyState(
              icon: LucideIcons.inbox,
              title: 'Belum ada permintaan',
              subtitle: _tab == 0
                  ? 'Ajukan penjemputan pertamamu sekarang.'
                  : 'Permintaan akan muncul di sini.',
            ),
          for (final p in shown) ...[
            _Card(
              p,
              onTap: () => _buka(p),
              onHapus: p.status == StatusP.dibatalkan ? () => _hapus(p) : null,
            ),
            const SizedBox(height: 12),
          ],
          if (_tab == 0) ...[
            const SizedBox(height: 4),
            OutlineButton(
              label: 'Ajukan Penjemputan Baru',
              icon: LucideIcons.plus,
              color: AppColors.merk700,
              onTap: () => Navigator.pushNamed(context, R.a1),
            ),
          ],
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final PermintaanData p;
  final VoidCallback onTap;
  final VoidCallback? onHapus;
  const _Card(this.p, {required this.onTap, this.onHapus});

  @override
  Widget build(BuildContext context) {
    final (label, tone) = statusInfo(p.status);
    final batal = p.status == StatusP.dibatalkan;
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(p.kode, style: T.label.copyWith(color: AppColors.slate500)),
              StatusPill(label, tone: tone),
            ],
          ),
          const SizedBox(height: 10),
          Text(p.lapak, style: T.bodyBold),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(LucideIcons.calendar,
                  size: 14, color: AppColors.slate500),
              const SizedBox(width: 6),
              Text(p.jadwal, style: T.s),
            ],
          ),
          if (batal && p.alasan.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Alasan: ${p.alasan}',
                style: T.s.copyWith(color: AppColors.rose600)),
          ],
          const SizedBox(height: 10),
          const Sep(),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text('${p.jenis} jenis · ±${p.kg} kg',
                    style: T.s.copyWith(color: AppColors.slate600)),
              ),
              if (onHapus != null)
                RowAction(LucideIcons.trash2, danger: true, onTap: onHapus!)
              else
                Text('± ${rupiah(p.nilai)}',
                    style: T.bodyBold.copyWith(
                        color: batal ? AppColors.slate400 : AppColors.nilai700)),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════ READ: Detail Permintaan ═══════════════════════════

class PermintaanDetailScreen extends StatefulWidget {
  const PermintaanDetailScreen({super.key});

  @override
  State<PermintaanDetailScreen> createState() => _PermintaanDetailState();
}

class _PermintaanDetailState extends State<PermintaanDetailScreen> {
  late PermintaanData p;
  bool _init = false;

  static const _alasan = [
    'Jadwal tidak cocok',
    'Barang sudah dijual',
    'Salah input barang',
    'Lainnya',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    p = (ModalRoute.of(context)?.settings.arguments as PermintaanData?) ??
        contohPermintaan().first;
  }

  Future<void> _edit() async {
    final r = await Navigator.pushNamed(context, R.wPermintaanEdit,
        arguments: p.copy());
    if (r is PermintaanData && mounted) {
      setState(() {
        p
          ..barang = r.barang
          ..hari = r.hari
          ..jam = r.jam
          ..catatan = r.catatan;
      });
      toast(context, 'Perubahan ${p.kode} disimpan');
    }
  }

  Future<void> _batalkan() async {
    var pilih = 0;
    final ok = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.putih,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColors.slate200,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Batalkan ${p.kode}?', style: T.m),
                const SizedBox(height: 4),
                Text('Pengepul akan diberi tahu. Pilih alasan pembatalan:',
                    style: T.s),
                const SizedBox(height: 12),
                for (int i = 0; i < _alasan.length; i++)
                  InkWell(
                    onTap: () => setSheet(() => pilih = i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: i == pilih
                                      ? AppColors.rose600
                                      : AppColors.slate300,
                                  width: i == pilih ? 6 : 1.5),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(_alasan[i], style: T.body),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                          label: 'Kembali',
                          onTap: () => Navigator.pop(ctx, false)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Batalkan',
                        color: AppColors.rose600,
                        onTap: () => Navigator.pop(ctx, true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (ok != true || !mounted) return;
    setState(() {
      p
        ..status = StatusP.dibatalkan
        ..alasan = _alasan[pilih];
    });
    toast(context, '${p.kode} dibatalkan');
  }

  Future<void> _hapus() async {
    final ok = await confirmDialog(context,
        title: 'Hapus ${p.kode}?',
        message: 'Permintaan akan dihapus permanen dari riwayatmu.');
    if (ok && mounted) Navigator.pop(context, 'hapus');
  }

  @override
  Widget build(BuildContext context) {
    final (label, tone) = statusInfo(p.status);
    final batal = p.status == StatusP.dibatalkan;
    final step = switch (p.status) {
      StatusP.menunggu => 1,
      StatusP.dijadwalkan => 2,
      StatusP.ditimbang => 4,
      StatusP.selesai => 6,
      StatusP.dibatalkan => 0,
    };
    return Scaffold(
      appBar: subBar(p.kode, p.lapak),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status permintaan', style: T.bodyBold),
                    StatusPill(label, tone: tone),
                  ],
                ),
                const SizedBox(height: 16),
                if (batal)
                  InfoBox(
                    icon: LucideIcons.circleX,
                    title: 'Permintaan dibatalkan',
                    text: 'Alasan: ${p.alasan.isEmpty ? '-' : p.alasan}',
                    bg: AppColors.rose50,
                    fg: AppColors.rose600,
                    textColor: AppColors.slate600,
                  )
                else
                  StatusTracker(current: step, activeColor: AppColors.merk600),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Barang
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const IconBox(LucideIcons.package),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Barang', style: T.bodyBold)),
                    Text('Harga dikunci', style: T.s),
                  ],
                ),
                for (final b in p.barang.where((b) => b.kg > 0)) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      EmojiTile(b.emoji, size: 36),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b.nama, style: T.bodyBold),
                            Text('est. ${b.kg} kg · × ${rupiah(b.harga)}',
                                style: T.s),
                          ],
                        ),
                      ),
                      Text(rupiah(b.kg * b.harga), style: T.bodyBold),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                const Sep(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estimasi · ${p.kg} kg',
                        style: T.body.copyWith(color: AppColors.slate600)),
                    Text('± ${rupiah(p.nilai)}',
                        style: T.l.copyWith(color: AppColors.nilai700)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Jadwal & alamat
          AppCard(
            child: Column(
              children: [
                _InfoRow(LucideIcons.calendar, 'Jadwal jemput', p.jadwal),
                const SizedBox(height: 12),
                _InfoRow(LucideIcons.mapPin, 'Alamat', p.alamat),
                const SizedBox(height: 12),
                _InfoRow(LucideIcons.stickyNote, 'Catatan',
                    p.catatan.isEmpty ? '-' : p.catatan),
              ],
            ),
          ),
          if (p.bisaDiubah) ...[
            const SizedBox(height: 12),
            const InfoBox(
              icon: LucideIcons.info,
              text: 'Permintaan masih bisa diubah atau dibatalkan sampai '
                  'pengepul berangkat menjemput.',
              bg: AppColors.sky50,
              fg: AppColors.sky700,
            ),
          ],
        ],
      ),
      bottomNavigationBar: p.bisaDiubah
          ? BottomActions(
              child: Row(
                children: [
                  Expanded(
                    child: OutlineButton(
                        label: 'Batalkan',
                        color: AppColors.rose600,
                        onTap: _batalkan),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                        label: 'Edit Permintaan',
                        icon: LucideIcons.pencil,
                        onTap: _edit),
                  ),
                ],
              ),
            )
          : batal
              ? BottomActions(
                  child: OutlineButton(
                      label: 'Hapus dari Riwayat',
                      icon: LucideIcons.trash2,
                      color: AppColors.rose600,
                      onTap: _hapus),
                )
              : null,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.merk600),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: T.s),
              Text(value, style: T.bodyBold),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════ UPDATE: Edit Permintaan ═══════════════════════════

class PermintaanEditScreen extends StatefulWidget {
  const PermintaanEditScreen({super.key});

  @override
  State<PermintaanEditScreen> createState() => _PermintaanEditState();
}

class _PermintaanEditState extends State<PermintaanEditScreen> {
  late PermintaanData p;
  late final TextEditingController _catatan;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    p = (ModalRoute.of(context)?.settings.arguments as PermintaanData?) ??
        contohPermintaan().first;
    _catatan = TextEditingController(text: p.catatan);
  }

  @override
  void dispose() {
    _catatan.dispose();
    super.dispose();
  }

  void _simpan() {
    if (p.kg == 0) {
      toast(context, 'Isi minimal 1 kg barang');
      return;
    }
    p.catatan = _catatan.text.trim();
    Navigator.pop(context, p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Edit Permintaan', p.kode),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
                  child: Text(p.lapak,
                      style: T.label.copyWith(color: AppColors.merk800)),
                ),
                const Icon(LucideIcons.lock,
                    size: 14, color: AppColors.merk700),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Barang', style: T.m),
          const SizedBox(height: 4),
          Text('Harga per kg tetap mengikuti harga saat permintaan dibuat.',
              style: T.s),
          const SizedBox(height: 12),
          for (final b in p.barang) ...[
            QtyItemRow(
              emoji: b.emoji,
              name: b.nama,
              price: b.harga,
              qty: b.kg,
              onChanged: (v) => setState(() => b.kg = v),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 6),
          const FieldLabel('Tanggal jemput'),
          const SizedBox(height: 8),
          DayPicker(
              selected: p.hari, onSelected: (i) => setState(() => p.hari = i)),
          const SizedBox(height: 16),
          const FieldLabel('Rentang waktu'),
          const SizedBox(height: 8),
          ChoicePills(
              items: jamList,
              selected: p.jam,
              onSelected: (i) => setState(() => p.jam = i)),
          const SizedBox(height: 16),
          LabeledField(
              'Catatan untuk pengepul (opsional)',
              AppTextField(
                  hint: 'Contoh: barang di garasi, bel rusak',
                  controller: _catatan,
                  maxLines: 2)),
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
                  Text('Estimasi · ${p.kg} kg', style: T.s),
                  Text(rupiah(p.nilai),
                      style: T.l.copyWith(color: AppColors.nilai700)),
                ],
              ),
            ),
            PrimaryButton(label: 'Simpan', expand: false, onTap: _simpan),
          ],
        ),
      ),
    );
  }
}

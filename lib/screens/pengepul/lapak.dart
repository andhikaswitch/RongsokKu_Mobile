import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../admin/harga.dart' show JenisData, contohJenis, kategoriList;

// CRUD Anggota 3 — Entitas target: PENGEPUL / LAPAK
//   Create : Registrasi lapak (publik/daftar.dart) · Tambah harga beli
//   Read   : Profil lapak & daftar harga beli
//   Update : Edit profil lapak · Edit harga beli · Buka/tutup lapak
//   Delete : Hapus harga beli · Hapus lapak

/// Data profil lapak (hanya untuk tampilan).
class LapakData {
  String nama, pemilik, wa, alamat, kecamatan, jamBuka, jamTutup;
  List<String> jenis;
  LapakData({
    required this.nama,
    required this.pemilik,
    required this.wa,
    required this.alamat,
    required this.kecamatan,
    required this.jamBuka,
    required this.jamTutup,
    required this.jenis,
  });
  LapakData copy() => LapakData(
      nama: nama,
      pemilik: pemilik,
      wa: wa,
      alamat: alamat,
      kecamatan: kecamatan,
      jamBuka: jamBuka,
      jamTutup: jamTutup,
      jenis: [...jenis]);
}

/// Harga beli lapak untuk satu jenis rongsok.
class HargaBeliData {
  final JenisData jenis;
  int harga;
  HargaBeliData(this.jenis, this.harga);
}

JenisData _jenis(String nama) =>
    contohJenis().firstWhere((j) => j.nama == nama);

/// Status harga lapak dibanding indeks pasar.
(String, Color) bandingIndeks(int harga, int indeks) {
  if (harga > indeks) return ('▲ di atas indeks', AppColors.merk600);
  if (harga < indeks) return ('▼ di bawah indeks', AppColors.rose600);
  return ('sesuai indeks', AppColors.slate500);
}

// ═════════════════════════════ READ: Profil Lapak ═════════════════════════════

class LapakScreen extends StatefulWidget {
  const LapakScreen({super.key});

  @override
  State<LapakScreen> createState() => _LapakScreenState();
}

class _LapakScreenState extends State<LapakScreen> {
  final _lapak = LapakData(
    nama: 'Lapak Hijau Karawang',
    pemilik: 'Darto Wijaya',
    wa: '0812-8888-1234',
    alamat: 'Jl. Tuparev No. 88',
    kecamatan: 'Karawang Barat',
    jamBuka: '07.00',
    jamTutup: '17.00',
    jenis: ['Kertas', 'Plastik', 'Logam'],
  );
  final _harga = [
    HargaBeliData(_jenis('Kardus'), 2500),
    HargaBeliData(_jenis('Koran'), 2700),
    HargaBeliData(_jenis('HVS / Buku'), 3200),
    HargaBeliData(_jenis('Botol PET'), 4000),
    HargaBeliData(_jenis('Besi'), 5200),
  ];
  bool _buka = true;

  // "Lapak Hijau Karawang" → "HK" (kata generik dilewati).
  String get _inisial {
    final w = _lapak.nama
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty);
    final inti = w.where((e) => !const {'lapak', 'pengepul'}
        .contains(e.toLowerCase()));
    return (inti.isEmpty ? w : inti)
        .take(2)
        .map((e) => e[0].toUpperCase())
        .join();
  }

  Future<void> _editLapak() async {
    final r = await Navigator.pushNamed(context, R.lapakEdit,
        arguments: _lapak.copy());
    if (r is LapakData && mounted) {
      setState(() {
        _lapak
          ..nama = r.nama
          ..pemilik = r.pemilik
          ..wa = r.wa
          ..alamat = r.alamat
          ..kecamatan = r.kecamatan
          ..jamBuka = r.jamBuka
          ..jamTutup = r.jamTutup
          ..jenis = r.jenis;
      });
      toast(context, 'Profil lapak diperbarui');
    }
  }

  Future<void> _tambahHarga() async {
    final r = await Navigator.pushNamed(context, R.hargaBeli,
        arguments: _HargaArgs(null, _harga.map((h) => h.jenis.nama).toList()));
    if (r is HargaBeliData && mounted) {
      setState(() => _harga.add(r));
      toast(context, 'Harga beli ${r.jenis.nama} ditambahkan');
    }
  }

  Future<void> _editHarga(HargaBeliData h) async {
    final r = await Navigator.pushNamed(context, R.hargaBeli,
        arguments: _HargaArgs(HargaBeliData(h.jenis, h.harga), const []));
    if (!mounted) return;
    if (r == 'hapus') {
      setState(() => _harga.remove(h));
      toast(context, 'Harga beli ${h.jenis.nama} dihapus');
    } else if (r is HargaBeliData) {
      setState(() => h.harga = r.harga);
      toast(context, 'Harga ${h.jenis.nama} jadi ${rupiah(r.harga)}/kg');
    }
  }

  Future<void> _hapusHarga(HargaBeliData h) async {
    final ok = await confirmDialog(context,
        title: 'Hapus harga ${h.jenis.nama}?',
        message: 'Warga tidak bisa lagi memilih ${h.jenis.nama} saat '
            'mengajukan penjemputan ke lapakmu.');
    if (!ok || !mounted) return;
    setState(() => _harga.remove(h));
    toast(context, 'Harga beli ${h.jenis.nama} dihapus');
  }

  Future<void> _toggleBuka(bool v) async {
    if (!v) {
      final ok = await confirmDialog(context,
          title: 'Tutup lapak sementara?',
          message: 'Lapakmu tetap tampil di pencarian dengan label '
              '"Tutup sementara" dan tidak menerima permintaan baru.',
          confirm: 'Tutup',
          danger: false,
          icon: LucideIcons.store);
      if (!ok) return;
    }
    if (!mounted) return;
    setState(() => _buka = v);
    toast(context, v ? 'Lapak dibuka kembali' : 'Lapak ditutup sementara');
  }

  Future<void> _hapusLapak() async {
    final ok = await confirmDialog(context,
        title: 'Hapus lapak?',
        message: 'Lapak, harga beli, dan saldo deposit tidak bisa '
            'dikembalikan. Pastikan tidak ada permintaan yang masih berjalan.',
        confirm: 'Hapus Lapak');
    if (!ok || !mounted) return;
    toast(context, 'Lapak dihapus');
    Navigator.pushNamedAndRemoveUntil(context, R.beranda, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Profil Lapak', 'Kelola data & harga beli',
          trailing: RowAction(LucideIcons.pencil, onTap: _editLapak)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Identitas
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InitialAvatar(_inisial, size: 52),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_lapak.nama, style: T.m),
                          const SizedBox(height: 4),
                          const VerifiedBadge(showText: true),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Sep(),
                KeyValue('Pemilik', _lapak.pemilik),
                KeyValue('WhatsApp', _lapak.wa),
                KeyValue('Alamat', '${_lapak.alamat}, ${_lapak.kecamatan}'),
                KeyValue('Jam operasional',
                    '${_lapak.jamBuka}–${_lapak.jamTutup}'),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final j in _lapak.jenis)
                      Pill(j,
                          bg: AppColors.slate100,
                          fg: AppColors.slate600,
                          fontSize: 10),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: SwitchRow(
              title: _buka ? 'Lapak buka' : 'Tutup sementara',
              subtitle: _buka
                  ? 'Menerima permintaan penjemputan'
                  : 'Tidak menerima permintaan baru',
              value: _buka,
              onChanged: _toggleBuka,
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader('Harga Beli per kg',
              action: '+ Tambah', onAction: _tambahHarga),
          const SizedBox(height: 12),
          if (_harga.isEmpty)
            const EmptyState(
                icon: LucideIcons.tags,
                title: 'Belum ada harga beli',
                subtitle: 'Tambahkan jenis rongsok yang kamu beli\n'
                    'agar warga bisa mengajukan penjemputan.')
          else
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (int i = 0; i < _harga.length; i++) ...[
                    if (i > 0) const Sep(),
                    _HargaRow(
                      _harga[i],
                      onEdit: () => _editHarga(_harga[i]),
                      onHapus: () => _hapusHarga(_harga[i]),
                    ),
                  ],
                ],
              ),
            ),
          const SizedBox(height: 16),
          const SectionHeader('Zona Berbahaya'),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            borderColor: AppColors.rose100,
            child: MenuTile(
              icon: LucideIcons.trash2,
              title: 'Hapus lapak',
              subtitle: 'Hapus permanen lapak & seluruh datanya',
              danger: true,
              onTap: _hapusLapak,
            ),
          ),
        ],
      ),
    );
  }
}

class _HargaRow extends StatelessWidget {
  final HargaBeliData h;
  final VoidCallback onEdit;
  final VoidCallback onHapus;
  const _HargaRow(this.h, {required this.onEdit, required this.onHapus});

  @override
  Widget build(BuildContext context) {
    final (note, color) = bandingIndeks(h.harga, h.jenis.indeks);
    return InkWell(
      onTap: onEdit,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            EmojiTile(h.jenis.emoji, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(h.jenis.nama, style: T.bodyBold),
                  Text('Indeks ${rupiah(h.jenis.indeks)}', style: T.s),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(rupiah(h.harga), style: T.bodyBold),
                Text(note, style: T.xs.copyWith(color: color)),
              ],
            ),
            const SizedBox(width: 10),
            RowAction(LucideIcons.trash2, danger: true, onTap: onHapus),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════ UPDATE: Edit Lapak ═══════════════════════════

class EditLapakScreen extends StatefulWidget {
  const EditLapakScreen({super.key});

  @override
  State<EditLapakScreen> createState() => _EditLapakScreenState();
}

class _EditLapakScreenState extends State<EditLapakScreen> {
  late LapakData _d;
  late final TextEditingController _nama, _pemilik, _wa, _alamat, _kec,
      _buka, _tutup;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    _d = (ModalRoute.of(context)?.settings.arguments as LapakData?) ??
        LapakData(
            nama: '',
            pemilik: '',
            wa: '',
            alamat: '',
            kecamatan: '',
            jamBuka: '07.00',
            jamTutup: '17.00',
            jenis: []);
    _nama = TextEditingController(text: _d.nama);
    _pemilik = TextEditingController(text: _d.pemilik);
    _wa = TextEditingController(text: _d.wa);
    _alamat = TextEditingController(text: _d.alamat);
    _kec = TextEditingController(text: _d.kecamatan);
    _buka = TextEditingController(text: _d.jamBuka);
    _tutup = TextEditingController(text: _d.jamTutup);
  }

  @override
  void dispose() {
    for (final c in [_nama, _pemilik, _wa, _alamat, _kec, _buka, _tutup]) {
      c.dispose();
    }
    super.dispose();
  }

  void _simpan() {
    if (_nama.text.trim().isEmpty || _alamat.text.trim().isEmpty) {
      toast(context, 'Nama lapak dan alamat wajib diisi');
      return;
    }
    if (_d.jenis.isEmpty) {
      toast(context, 'Pilih minimal satu jenis yang diterima');
      return;
    }
    Navigator.pop(
      context,
      LapakData(
        nama: _nama.text.trim(),
        pemilik: _pemilik.text.trim(),
        wa: _wa.text.trim(),
        alamat: _alamat.text.trim(),
        kecamatan: _kec.text.trim(),
        jamBuka: _buka.text.trim(),
        jamTutup: _tutup.text.trim(),
        jenis: _d.jenis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Edit Profil Lapak', _d.nama),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Foto lapak
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.imagePlus,
                    size: 28, color: AppColors.slate400),
                const SizedBox(height: 6),
                Text('Ganti foto lapak',
                    style: T.label.copyWith(color: AppColors.merk700)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          LabeledField('Nama lapak',
              AppTextField(hint: 'Nama usaha', controller: _nama)),
          const SizedBox(height: 16),
          LabeledField('Nama pemilik',
              AppTextField(hint: 'Sesuai KTP', controller: _pemilik)),
          const SizedBox(height: 16),
          LabeledField(
              'Nomor WhatsApp',
              AppTextField(
                  hint: '08xxxxxxxxxx',
                  controller: _wa,
                  keyboardType: TextInputType.phone)),
          const SizedBox(height: 16),
          LabeledField(
              'Alamat lapak',
              AppTextField(
                  hint: 'Nama jalan & nomor', controller: _alamat, maxLines: 2)),
          const SizedBox(height: 16),
          LabeledField(
              'Kecamatan', AppTextField(hint: 'Kecamatan', controller: _kec)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LabeledField(
                    'Jam buka',
                    AppTextField(
                        hint: '07.00',
                        controller: _buka,
                        icon: LucideIcons.clock)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabeledField(
                    'Jam tutup',
                    AppTextField(
                        hint: '17.00',
                        controller: _tutup,
                        icon: LucideIcons.clock)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const FieldLabel('Jenis yang diterima'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final k in kategoriList)
                GestureDetector(
                  onTap: () => setState(() => _d.jenis.contains(k)
                      ? _d.jenis.remove(k)
                      : _d.jenis.add(k)),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _d.jenis.contains(k)
                          ? AppColors.merk50
                          : AppColors.putih,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          color: _d.jenis.contains(k)
                              ? AppColors.merk500
                              : AppColors.slate200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_d.jenis.contains(k)) ...[
                          const Icon(LucideIcons.check,
                              size: 14, color: AppColors.merk700),
                          const SizedBox(width: 4),
                        ],
                        Text(k,
                            style: T.label.copyWith(
                                color: _d.jenis.contains(k)
                                    ? AppColors.merk700
                                    : AppColors.slate600)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: PrimaryButton(label: 'Simpan Perubahan', onTap: _simpan),
      ),
    );
  }
}

// ═════════════════ CREATE / UPDATE / DELETE: Form Harga Beli ═════════════════

class _HargaArgs {
  final HargaBeliData? edit;
  final List<String> sudahAda;
  const _HargaArgs(this.edit, this.sudahAda);
}

class HargaBeliFormScreen extends StatefulWidget {
  const HargaBeliFormScreen({super.key});

  @override
  State<HargaBeliFormScreen> createState() => _HargaBeliFormState();
}

class _HargaBeliFormState extends State<HargaBeliFormScreen> {
  HargaBeliData? _edit;
  late List<JenisData> _pilihan;
  int _pilih = 0;
  final _harga = TextEditingController();
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final args = ModalRoute.of(context)?.settings.arguments as _HargaArgs?;
    _edit = args?.edit;
    final ada = args?.sudahAda ?? const [];
    _pilihan = _edit != null
        ? [_edit!.jenis]
        : contohJenis().where((j) => !ada.contains(j.nama)).toList();
    _harga.text = _edit != null
        ? '${_edit!.harga}'
        : (_pilihan.isEmpty ? '' : '${_pilihan.first.indeks}');
  }

  @override
  void dispose() {
    _harga.dispose();
    super.dispose();
  }

  int get _nilai =>
      int.tryParse(_harga.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

  void _simpan() {
    if (_pilihan.isEmpty) return;
    if (_nilai <= 0) {
      toast(context, 'Isi harga beli lebih dari 0');
      return;
    }
    Navigator.pop(context, HargaBeliData(_pilihan[_pilih], _nilai));
  }

  Future<void> _hapus() async {
    final ok = await confirmDialog(context,
        title: 'Hapus harga ${_edit!.jenis.nama}?',
        message: 'Jenis ini tidak bisa dipilih warga untuk lapakmu.');
    if (ok && mounted) Navigator.pop(context, 'hapus');
  }

  @override
  Widget build(BuildContext context) {
    final edit = _edit != null;
    if (_pilihan.isEmpty) {
      return Scaffold(
        appBar: subBar('Tambah Harga Beli', 'Semua jenis sudah ada'),
        body: const EmptyState(
            icon: LucideIcons.circleCheck,
            title: 'Semua jenis sudah punya harga',
            subtitle: 'Ubah harga dari daftar di Profil Lapak.'),
      );
    }
    final j = _pilihan[_pilih];
    final (note, color) = bandingIndeks(_nilai, j.indeks);
    return Scaffold(
      appBar: subBar(edit ? 'Edit Harga Beli' : 'Tambah Harga Beli',
          edit ? j.nama : 'Pilih jenis & tentukan harga'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const FieldLabel('Jenis rongsok'),
          const SizedBox(height: 8),
          if (edit)
            AppCard(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  EmojiTile(j.emoji, size: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(j.nama, style: T.bodyBold),
                        Text(j.kategori, style: T.s),
                      ],
                    ),
                  ),
                  const Icon(LucideIcons.lock,
                      size: 16, color: AppColors.slate400),
                ],
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 0; i < _pilihan.length; i++)
                  GestureDetector(
                    onTap: () => setState(() {
                      _pilih = i;
                      _harga.text = '${_pilihan[i].indeks}';
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            i == _pilih ? AppColors.merk600 : AppColors.putih,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                            color: i == _pilih
                                ? AppColors.merk600
                                : AppColors.slate200),
                      ),
                      child: Text('${_pilihan[i].emoji} ${_pilihan[i].nama}',
                          style: T.label.copyWith(
                              color: i == _pilih
                                  ? AppColors.putih
                                  : AppColors.slate600)),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 16),
          AppCard(
            color: AppColors.slate50,
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    const IconBox(LucideIcons.chartLine,
                        bg: AppColors.putih, fg: AppColors.merk700),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text('Harga pasar ${j.nama}',
                            style: T.bodyBold)),
                  ],
                ),
                KeyValue('Indeks RongsokKu', '${rupiah(j.indeks)}/kg'),
                KeyValue('Rentang acuan',
                    '${rupiah(j.min)} – ${rupiah(j.max)}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          LabeledField(
              'Harga beli lapakmu',
              AppTextField(
                  hint: '0',
                  prefix: 'Rp ',
                  suffix: '/kg',
                  controller: _harga,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}))),
          const SizedBox(height: 8),
          if (_nilai > 0)
            Text(note, style: T.label.copyWith(color: color)),
          const SizedBox(height: 12),
          const InfoBox(
            icon: LucideIcons.info,
            text: 'Harga dikunci saat warga mengirim permintaan. Menurunkan '
                'harga di lokasi akan menurunkan skor kepatuhan harga.',
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Row(
          children: [
            if (edit) ...[
              Expanded(
                child: OutlineButton(
                    label: 'Hapus', color: AppColors.rose600, onTap: _hapus),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              flex: 2,
              child: PrimaryButton(
                  label: edit ? 'Simpan Perubahan' : 'Simpan Harga',
                  onTap: _simpan),
            ),
          ],
        ),
      ),
    );
  }
}

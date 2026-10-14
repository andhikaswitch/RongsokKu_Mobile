import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

// CRUD Anggota 2 — Entitas pengelola: ADMIN (master jenis rongsok & harga acuan)
//   Create : Tambah jenis rongsok
//   Read   : Daftar jenis per kategori (cari & saring)
//   Update : Edit nama, kategori, ikon & harga acuan
//   Delete : Hapus jenis rongsok

/// Data jenis rongsok (hanya untuk tampilan).
class JenisData {
  String emoji, nama, kategori;
  int min, max, indeks;
  JenisData(this.emoji, this.nama, this.kategori, this.min, this.max,
      this.indeks);
  JenisData copy() => JenisData(emoji, nama, kategori, min, max, indeks);
}

const kategoriList = ['Kertas', 'Plastik', 'Logam', 'Kaca', 'Kain', 'Elektronik'];
const ikonList = ['📄', '📰', '📚', '🧴', '🪣', '🔩', '🥫', '🪙', '🍾', '🧺', '🔌', '📺', '📦', '♻️'];

List<JenisData> contohJenis() => [
      JenisData('📄', 'Kardus', 'Kertas', 1800, 2600, 2400),
      JenisData('📰', 'Koran', 'Kertas', 2000, 3000, 2700),
      JenisData('📚', 'HVS / Buku', 'Kertas', 2500, 3500, 3100),
      JenisData('🧴', 'Botol PET', 'Plastik', 3500, 5000, 4100),
      JenisData('🪣', 'Plastik Keras', 'Plastik', 2000, 3200, 2600),
      JenisData('🔩', 'Besi', 'Logam', 4500, 6000, 5300),
      JenisData('🥫', 'Aluminium', 'Logam', 10000, 14000, 12000),
      JenisData('🪙', 'Tembaga', 'Logam', 85000, 95000, 92000),
      JenisData('🍾', 'Botol Kaca', 'Kaca', 300, 700, 500),
      JenisData('🧺', 'Kain Perca', 'Kain', 500, 1200, 900),
      JenisData('🔌', 'Kabel', 'Elektronik', 8000, 12000, 10000),
    ];

String _ribu(int v) => rupiah(v).replaceFirst('Rp ', '');

// ═══════════════════════════ READ: Daftar Jenis ═══════════════════════════

class KelolaHargaScreen extends StatefulWidget {
  const KelolaHargaScreen({super.key});

  @override
  State<KelolaHargaScreen> createState() => _KelolaHargaScreenState();
}

class _KelolaHargaScreenState extends State<KelolaHargaScreen> {
  final _data = contohJenis();
  int _filter = 0;
  String _cari = '';

  List<String> get _filters => ['Semua', ...kategoriList];

  Future<void> _tambah() async {
    final r = await Navigator.pushNamed(context, R.adHargaForm);
    if (r is JenisData && mounted) {
      setState(() => _data.add(r));
      toast(context, '"${r.nama}" ditambahkan ke ${r.kategori}');
    }
  }

  Future<void> _edit(JenisData j) async {
    final r = await Navigator.pushNamed(context, R.adHargaForm,
        arguments: j.copy());
    if (!mounted) return;
    if (r == 'hapus') {
      setState(() => _data.remove(j));
      toast(context, '"${j.nama}" dihapus');
    } else if (r is JenisData) {
      setState(() => _data[_data.indexOf(j)] = r);
      toast(context, '"${r.nama}" diperbarui');
    }
  }

  Future<void> _hapus(JenisData j) async {
    final ok = await confirmDialog(context,
        title: 'Hapus "${j.nama}"?',
        message: 'Jenis ini hilang dari Pusat Harga dan tidak bisa dipilih '
            'warga maupun pengepul. Harga beli lapak untuk jenis ini ikut '
            'dihapus.');
    if (!ok || !mounted) return;
    setState(() => _data.remove(j));
    toast(context, '"${j.nama}" dihapus');
  }

  @override
  Widget build(BuildContext context) {
    final shown = _data.where((j) {
      final okKat = _filter == 0 || j.kategori == _filters[_filter];
      final okCari = j.nama.toLowerCase().contains(_cari.toLowerCase());
      return okKat && okCari;
    }).toList();
    final groups = <String, List<JenisData>>{};
    for (final j in shown) {
      groups.putIfAbsent(j.kategori, () => []).add(j);
    }

    return Scaffold(
      appBar: subBar('Jenis & Harga Rongsok',
          '${_data.length} jenis · master harga acuan',
          trailing: RowAction(LucideIcons.plus, onTap: _tambah)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppTextField(
            hint: 'Cari jenis rongsok…',
            icon: LucideIcons.search,
            onChanged: (v) => setState(() => _cari = v),
          ),
          const SizedBox(height: 12),
          FilterChips(
            items: _filters,
            selected: _filter,
            onSelected: (i) => setState(() => _filter = i),
          ),
          const SizedBox(height: 12),
          if (groups.isEmpty)
            const EmptyState(
                icon: LucideIcons.searchX,
                title: 'Tidak ada jenis',
                subtitle: 'Coba kata kunci lain atau tambah jenis baru.'),
          for (final e in groups.entries) ...[
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Row(
                      children: [
                        Expanded(child: Text(e.key, style: T.bodyBold)),
                        Text('${e.value.length} jenis', style: T.s),
                      ],
                    ),
                  ),
                  for (final j in e.value) ...[
                    const Sep(),
                    InkWell(
                      onTap: () => _edit(j),
                      child: Padding(
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
                                  Text(
                                      'Acuan Rp ${_ribu(j.min)}–${_ribu(j.max)}',
                                      style: T.s),
                                  Text('Indeks ${rupiah(j.indeks)}/kg',
                                      style: T.s.copyWith(
                                          color: AppColors.nilai700,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            RowAction(LucideIcons.pencil,
                                onTap: () => _edit(j)),
                            const SizedBox(width: 6),
                            RowAction(LucideIcons.trash2,
                                danger: true, onTap: () => _hapus(j)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: PrimaryButton(
            label: 'Tambah Jenis Rongsok',
            icon: LucideIcons.plus,
            onTap: _tambah),
      ),
    );
  }
}

// ═════════════════ CREATE / UPDATE / DELETE: Form Jenis ═════════════════

class JenisFormScreen extends StatefulWidget {
  const JenisFormScreen({super.key});

  @override
  State<JenisFormScreen> createState() => _JenisFormScreenState();
}

class _JenisFormScreenState extends State<JenisFormScreen> {
  JenisData? _edit;
  int _ikon = 0;
  int _kategori = 0;
  final _nama = TextEditingController();
  final _min = TextEditingController();
  final _max = TextEditingController();
  final _indeks = TextEditingController();
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    _edit = ModalRoute.of(context)?.settings.arguments as JenisData?;
    final e = _edit;
    if (e != null) {
      _ikon = ikonList.indexOf(e.emoji).clamp(0, ikonList.length - 1);
      _kategori =
          kategoriList.indexOf(e.kategori).clamp(0, kategoriList.length - 1);
      _nama.text = e.nama;
      _min.text = '${e.min}';
      _max.text = '${e.max}';
      _indeks.text = '${e.indeks}';
    }
  }

  @override
  void dispose() {
    _nama.dispose();
    _min.dispose();
    _max.dispose();
    _indeks.dispose();
    super.dispose();
  }

  int _n(TextEditingController c) =>
      int.tryParse(c.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

  void _simpan() {
    final min = _n(_min), max = _n(_max), indeks = _n(_indeks);
    if (_nama.text.trim().isEmpty) {
      toast(context, 'Nama jenis wajib diisi');
      return;
    }
    if (min <= 0 || max <= 0 || indeks <= 0) {
      toast(context, 'Isi semua harga dengan angka lebih dari 0');
      return;
    }
    if (min > max) {
      toast(context, 'Harga minimum tidak boleh lebih besar dari maksimum');
      return;
    }
    if (indeks < min || indeks > max) {
      toast(context, 'Harga indeks harus di antara minimum dan maksimum');
      return;
    }
    Navigator.pop(
        context,
        JenisData(ikonList[_ikon], _nama.text.trim(), kategoriList[_kategori],
            min, max, indeks));
  }

  Future<void> _hapus() async {
    final ok = await confirmDialog(context,
        title: 'Hapus "${_edit!.nama}"?',
        message: 'Jenis ini hilang dari Pusat Harga dan tidak bisa dipilih '
            'lagi.');
    if (ok && mounted) Navigator.pop(context, 'hapus');
  }

  @override
  Widget build(BuildContext context) {
    final edit = _edit != null;
    final indeks = _n(_indeks);
    return Scaffold(
      appBar: subBar(edit ? 'Edit Jenis Rongsok' : 'Tambah Jenis Rongsok',
          edit ? _edit!.nama : 'Master data harga acuan'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const FieldLabel('Ikon'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < ikonList.length; i++)
                GestureDetector(
                  onTap: () => setState(() => _ikon = i),
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: i == _ikon ? AppColors.merk50 : AppColors.putih,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: i == _ikon
                              ? AppColors.merk500
                              : AppColors.slate200,
                          width: i == _ikon ? 1.5 : 1),
                    ),
                    child: Text(ikonList[i],
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          LabeledField(
              'Nama jenis',
              AppTextField(
                  hint: 'Contoh: Kardus, Botol PET',
                  controller: _nama,
                  onChanged: (_) => setState(() {}))),
          const SizedBox(height: 16),
          const FieldLabel('Kategori'),
          const SizedBox(height: 8),
          ChoicePills(
            items: kategoriList,
            selected: _kategori,
            onSelected: (i) => setState(() => _kategori = i),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LabeledField(
                    'Harga acuan min',
                    AppTextField(
                        hint: '0',
                        prefix: 'Rp ',
                        suffix: '/kg',
                        controller: _min,
                        keyboardType: TextInputType.number)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabeledField(
                    'Harga acuan maks',
                    AppTextField(
                        hint: '0',
                        prefix: 'Rp ',
                        suffix: '/kg',
                        controller: _max,
                        keyboardType: TextInputType.number)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LabeledField(
              'Harga indeks (acuan utama)',
              AppTextField(
                  hint: '0',
                  prefix: 'Rp ',
                  suffix: '/kg',
                  controller: _indeks,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}))),
          const SizedBox(height: 12),
          const InfoBox(
            icon: LucideIcons.info,
            text: 'Harga indeks tampil di Pusat Harga dan jadi patokan '
                'skor kepatuhan harga tiap lapak.',
            bg: AppColors.sky50,
            fg: AppColors.sky700,
          ),
          const SizedBox(height: 16),
          Text('Pratinjau di Pusat Harga', style: T.label),
          const SizedBox(height: 8),
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                EmojiTile(ikonList[_ikon], size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          _nama.text.trim().isEmpty
                              ? 'Nama jenis'
                              : _nama.text.trim(),
                          style: T.bodyBold),
                      Text(kategoriList[_kategori], style: T.s),
                    ],
                  ),
                ),
                Text(indeks > 0 ? rupiah(indeks) : 'Rp –', style: T.bodyBold),
              ],
            ),
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
                  label: edit ? 'Simpan Perubahan' : 'Simpan Jenis',
                  onTap: _simpan),
            ),
          ],
        ),
      ),
    );
  }
}

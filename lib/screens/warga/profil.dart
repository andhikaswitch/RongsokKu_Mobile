import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'shell.dart';

// CRUD Anggota 1 — Entitas kunci: WARGA
//   Create : Daftar akun (publik/daftar.dart) · Tambah alamat
//   Read   : Profil & daftar alamat
//   Update : Edit profil · Edit alamat · Jadikan alamat utama
//   Delete : Hapus alamat · Nonaktifkan akun

/// Data profil warga (hanya untuk tampilan).
class ProfilData {
  String nama, wa, email;
  ProfilData(this.nama, this.wa, this.email);
  ProfilData copy() => ProfilData(nama, wa, email);
}

/// Data satu alamat penjemputan (hanya untuk tampilan).
class AlamatData {
  String label, detail, kelurahan, kecamatan, patokan;
  bool utama;
  AlamatData({
    required this.label,
    required this.detail,
    required this.kelurahan,
    required this.kecamatan,
    this.patokan = '',
    this.utama = false,
  });
  AlamatData copy() => AlamatData(
      label: label,
      detail: detail,
      kelurahan: kelurahan,
      kecamatan: kecamatan,
      patokan: patokan,
      utama: utama);
}

/// Penanda hasil form "hapus".
const hapusResult = '__hapus__';

// ═════════════════════════════ READ: Profil ═════════════════════════════

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _profil =
      ProfilData('Siti Aminah', '0812-3456-7890', 'siti@warga.test');
  final _alamat = [
    AlamatData(
        label: 'Rumah',
        detail: 'Jl. Tuparev No. 21, RT 03/RW 05',
        kelurahan: 'Adiarsa Timur',
        kecamatan: 'Karawang Barat',
        patokan: 'Dekat Masjid Al-Ikhlas',
        utama: true),
    AlamatData(
        label: 'Warung',
        detail: 'Jl. Kertabumi No. 5',
        kelurahan: 'Karawang Kulon',
        kecamatan: 'Karawang Barat'),
  ];

  String get _inisial => _profil.nama
      .trim()
      .split(RegExp(r'\s+'))
      .where((e) => e.isNotEmpty)
      .take(2)
      .map((e) => e[0].toUpperCase())
      .join();

  Future<void> _editProfil() async {
    final r = await Navigator.pushNamed(context, R.wProfilEdit,
        arguments: _profil.copy());
    if (r is ProfilData) {
      setState(() {
        _profil
          ..nama = r.nama
          ..wa = r.wa
          ..email = r.email;
      });
      if (mounted) toast(context, 'Profil berhasil diperbarui');
    }
  }

  Future<void> _tambahAlamat() async {
    final r = await Navigator.pushNamed(context, R.wAlamat);
    if (r is AlamatData) {
      setState(() {
        if (r.utama || _alamat.isEmpty) {
          for (final a in _alamat) {
            a.utama = false;
          }
          r.utama = true;
        }
        _alamat.add(r);
      });
      if (mounted) toast(context, 'Alamat "${r.label}" ditambahkan');
    }
  }

  Future<void> _editAlamat(int i) async {
    final r = await Navigator.pushNamed(context, R.wAlamat,
        arguments: _alamat[i].copy());
    if (r == hapusResult) {
      _hapus(i, tanya: false);
    } else if (r is AlamatData) {
      setState(() {
        if (r.utama) {
          for (final a in _alamat) {
            a.utama = false;
          }
        }
        _alamat[i] = r;
        if (!_alamat.any((a) => a.utama)) _alamat.first.utama = true;
      });
      if (mounted) toast(context, 'Alamat "${r.label}" diperbarui');
    }
  }

  Future<void> _hapus(int i, {bool tanya = true}) async {
    final a = _alamat[i];
    if (a.utama && _alamat.length > 1) {
      toast(context, 'Jadikan alamat lain sebagai utama sebelum menghapus');
      return;
    }
    if (tanya) {
      final ok = await confirmDialog(context,
          title: 'Hapus alamat "${a.label}"?',
          message: '${a.detail}, ${a.kelurahan}\n'
              'Alamat ini tidak bisa dipilih lagi saat mengajukan penjemputan.');
      if (!ok) return;
    }
    setState(() => _alamat.removeAt(i));
    if (mounted) toast(context, 'Alamat "${a.label}" dihapus');
  }

  void _jadikanUtama(int i) {
    setState(() {
      for (final a in _alamat) {
        a.utama = false;
      }
      _alamat[i].utama = true;
    });
    toast(context, '"${_alamat[i].label}" jadi alamat utama');
  }

  Future<void> _nonaktifkan() async {
    final ok = await confirmDialog(context,
        title: 'Nonaktifkan akun?',
        message: 'Akunmu tidak bisa dipakai untuk mengajukan penjemputan. '
            'Riwayat transaksi tetap tersimpan.',
        confirm: 'Nonaktifkan',
        icon: LucideIcons.userX);
    if (!ok || !mounted) return;
    toast(context, 'Akun dinonaktifkan');
    Navigator.pushNamedAndRemoveUntil(context, R.beranda, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: panelBar('Akun Saya', 'Profil & alamat penjemputan'),
      bottomNavigationBar: wargaNav(context, 4),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu profil
          AppCard(
            child: Row(
              children: [
                InitialAvatar(_inisial,
                    size: 52,
                    circle: true,
                    bg: AppColors.nilai100,
                    fg: AppColors.nilai700),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_profil.nama, style: T.m),
                      const SizedBox(height: 2),
                      Text(_profil.wa, style: T.s),
                      Text(_profil.email, style: T.s),
                    ],
                  ),
                ),
                RowAction(LucideIcons.pencil, onTap: _editProfil),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader('Alamat Penjemputan',
              action: '+ Tambah', onAction: _tambahAlamat),
          const SizedBox(height: 12),
          if (_alamat.isEmpty)
            const EmptyState(
                icon: LucideIcons.mapPin,
                title: 'Belum ada alamat',
                subtitle: 'Tambahkan alamat agar pengepul tahu\n'
                    'ke mana harus menjemput.'),
          for (int i = 0; i < _alamat.length; i++) ...[
            _AlamatCard(
              data: _alamat[i],
              onEdit: () => _editAlamat(i),
              onHapus: () => _hapus(i),
              onUtama: () => _jadikanUtama(i),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 6),
          const SectionHeader('Lainnya'),
          const SizedBox(height: 12),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                MenuTile(
                  icon: LucideIcons.truck,
                  title: 'Permintaan Saya',
                  subtitle: 'Riwayat & status penjemputan',
                  onTap: () => goTab(context, R.wPermintaan, R.wDash),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.leaf,
                  title: 'Dampak & Lencana',
                  subtitle: 'Kontribusimu untuk lingkungan',
                  onTap: () => Navigator.pushNamed(context, R.dampak),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.chartLine,
                  title: 'Pusat Harga',
                  subtitle: 'Indeks harga rongsok terkini',
                  onTap: () => Navigator.pushNamed(context, R.harga),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                MenuTile(
                  icon: LucideIcons.logOut,
                  title: 'Keluar',
                  danger: true,
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, R.beranda, (r) => false),
                ),
                const Sep(),
                MenuTile(
                  icon: LucideIcons.userX,
                  title: 'Nonaktifkan akun',
                  subtitle: 'Hentikan sementara akun warga',
                  danger: true,
                  onTap: _nonaktifkan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlamatCard extends StatelessWidget {
  final AlamatData data;
  final VoidCallback onEdit;
  final VoidCallback onHapus;
  final VoidCallback onUtama;
  const _AlamatCard({
    required this.data,
    required this.onEdit,
    required this.onHapus,
    required this.onUtama,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onEdit,
      borderColor: data.utama ? AppColors.merk200 : AppColors.slate200,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBox(
              data.label == 'Rumah'
                  ? LucideIcons.house
                  : data.label == 'Kantor'
                      ? LucideIcons.building2
                      : data.label == 'Warung'
                          ? LucideIcons.store
                          : LucideIcons.mapPin,
              size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(data.label, style: T.bodyBold),
                    if (data.utama) ...[
                      const SizedBox(width: 6),
                      const Pill('Utama',
                          bg: AppColors.merk50,
                          fg: AppColors.merk700,
                          fontSize: 10,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text('${data.detail}, ${data.kelurahan}, ${data.kecamatan}',
                    style: T.s.copyWith(color: AppColors.slate600)),
                if (data.patokan.isNotEmpty)
                  Text('Patokan: ${data.patokan}', style: T.s),
                if (!data.utama) ...[
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: onUtama,
                    child: Text('Jadikan utama',
                        style: T.label.copyWith(color: AppColors.merk700)),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              RowAction(LucideIcons.pencil, onTap: onEdit),
              const SizedBox(height: 6),
              RowAction(LucideIcons.trash2, danger: true, onTap: onHapus),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════ UPDATE: Edit Profil ═══════════════════════════

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  late final ProfilData _awal;
  late final _nama = TextEditingController(text: _awal.nama);
  late final _wa = TextEditingController(text: _awal.wa);
  late final _email = TextEditingController(text: _awal.email);
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _awal = (ModalRoute.of(context)?.settings.arguments as ProfilData?) ??
        ProfilData('Siti Aminah', '0812-3456-7890', 'siti@warga.test');
    _init = true;
  }

  @override
  void dispose() {
    _nama.dispose();
    _wa.dispose();
    _email.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_nama.text.trim().isEmpty || _wa.text.trim().isEmpty) {
      toast(context, 'Nama dan nomor WhatsApp wajib diisi');
      return;
    }
    Navigator.pop(
        context, ProfilData(_nama.text.trim(), _wa.text.trim(), _email.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Edit Profil', 'Perbarui data akunmu'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: [
                const InitialAvatar('SA',
                    size: 76,
                    circle: true,
                    bg: AppColors.nilai100,
                    fg: AppColors.nilai700),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.merk600,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.putih, width: 2),
                    ),
                    child: const Icon(LucideIcons.camera,
                        size: 14, color: AppColors.putih),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text('Ubah foto',
                style: T.label.copyWith(color: AppColors.merk700)),
          ),
          const SizedBox(height: 20),
          LabeledField('Nama Lengkap',
              AppTextField(hint: 'Nama sesuai KTP', controller: _nama)),
          const SizedBox(height: 16),
          LabeledField(
              'Nomor WhatsApp',
              AppTextField(
                  hint: '08xxxxxxxxxx',
                  controller: _wa,
                  keyboardType: TextInputType.phone)),
          const SizedBox(height: 16),
          LabeledField(
              'Alamat Email',
              AppTextField(
                  hint: 'nama@email.com',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress)),
          const SizedBox(height: 20),
          Text('Ubah Kata Sandi', style: T.m),
          const SizedBox(height: 4),
          Text('Kosongkan jika tidak ingin mengganti.', style: T.s),
          const SizedBox(height: 12),
          const LabeledField('Kata sandi lama',
              AppTextField(hint: '••••••••', obscure: true)),
          const SizedBox(height: 16),
          const LabeledField('Kata sandi baru',
              AppTextField(hint: 'Minimal 8 karakter', obscure: true)),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: PrimaryButton(label: 'Simpan Perubahan', onTap: _simpan),
      ),
    );
  }
}

// ═══════════════════ CREATE / UPDATE / DELETE: Form Alamat ═══════════════════

class AlamatFormScreen extends StatefulWidget {
  const AlamatFormScreen({super.key});

  @override
  State<AlamatFormScreen> createState() => _AlamatFormScreenState();
}

class _AlamatFormScreenState extends State<AlamatFormScreen> {
  static const _labels = ['Rumah', 'Kantor', 'Warung', 'Lainnya'];

  AlamatData? _edit;
  int _label = 0;
  bool _utama = false;
  final _detail = TextEditingController();
  final _kel = TextEditingController();
  final _kec = TextEditingController();
  final _patokan = TextEditingController();
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    _edit = ModalRoute.of(context)?.settings.arguments as AlamatData?;
    final e = _edit;
    if (e != null) {
      _label = _labels.indexOf(e.label).clamp(0, _labels.length - 1);
      _utama = e.utama;
      _detail.text = e.detail;
      _kel.text = e.kelurahan;
      _kec.text = e.kecamatan;
      _patokan.text = e.patokan;
    } else {
      _kec.text = 'Karawang Barat';
    }
  }

  @override
  void dispose() {
    _detail.dispose();
    _kel.dispose();
    _kec.dispose();
    _patokan.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_detail.text.trim().isEmpty ||
        _kel.text.trim().isEmpty ||
        _kec.text.trim().isEmpty) {
      toast(context, 'Lengkapi alamat, kelurahan, dan kecamatan');
      return;
    }
    Navigator.pop(
      context,
      AlamatData(
        label: _labels[_label],
        detail: _detail.text.trim(),
        kelurahan: _kel.text.trim(),
        kecamatan: _kec.text.trim(),
        patokan: _patokan.text.trim(),
        utama: _utama,
      ),
    );
  }

  Future<void> _hapus() async {
    final ok = await confirmDialog(context,
        title: 'Hapus alamat ini?',
        message: 'Alamat "${_labels[_label]}" akan dihapus dari akunmu.');
    if (ok && mounted) Navigator.pop(context, hapusResult);
  }

  @override
  Widget build(BuildContext context) {
    final edit = _edit != null;
    return Scaffold(
      appBar: subBar(edit ? 'Edit Alamat' : 'Tambah Alamat',
          edit ? _edit!.label : 'Alamat penjemputan baru'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pratinjau peta
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2EC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(LucideIcons.mapPin,
                    size: 32, color: AppColors.merk600),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.putih,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.slate200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.locateFixed,
                            size: 14, color: AppColors.merk700),
                        const SizedBox(width: 4),
                        Text('Pakai lokasi saat ini',
                            style: T.xs.copyWith(color: AppColors.merk700)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const FieldLabel('Label alamat'),
          const SizedBox(height: 8),
          ChoicePills(
            items: _labels,
            selected: _label,
            onSelected: (i) => setState(() => _label = i),
          ),
          const SizedBox(height: 16),
          LabeledField(
              'Alamat lengkap',
              AppTextField(
                  hint: 'Nama jalan, nomor rumah, RT/RW',
                  controller: _detail,
                  maxLines: 3)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LabeledField('Kelurahan',
                    AppTextField(hint: 'Kelurahan', controller: _kel)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabeledField('Kecamatan',
                    AppTextField(hint: 'Kecamatan', controller: _kec)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LabeledField(
              'Patokan (opsional)',
              AppTextField(
                  hint: 'Contoh: pagar hijau, dekat masjid',
                  controller: _patokan)),
          const SizedBox(height: 16),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: SwitchRow(
              title: 'Jadikan alamat utama',
              subtitle: 'Dipakai otomatis saat mengajukan penjemputan',
              value: _utama,
              onChanged: (v) => setState(() => _utama = v),
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
                  label: edit ? 'Simpan Perubahan' : 'Simpan Alamat',
                  onTap: _simpan),
            ),
          ],
        ),
      ),
    );
  }
}

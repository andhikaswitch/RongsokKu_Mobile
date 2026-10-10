import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({super.key});

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  int _peran = 0; // 0 warga, 1 pengepul

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subBar('Buat Akun RongsokKu', 'Gratis, kurang dari 2 menit'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const FieldLabel('Daftar sebagai'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _RoleCard(
                  icon: LucideIcons.house,
                  title: 'Warga',
                  subtitle: 'Saya ingin menjual rongsok',
                  selected: _peran == 0,
                  onTap: () => setState(() => _peran = 0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RoleCard(
                  icon: LucideIcons.truck,
                  title: 'Pengepul',
                  subtitle: 'Saya membeli & menjemput',
                  selected: _peran == 1,
                  onTap: () => setState(() => _peran = 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const FieldLabel('Nama Lengkap'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'Nama sesuai KTP'),
          const SizedBox(height: 18),
          const FieldLabel('Nomor WhatsApp'),
          const SizedBox(height: 8),
          const AppTextField(hint: '08xxxxxxxxxx'),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _LabeledField('Kecamatan', 'Karawang Barat'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _LabeledField('Kelurahan', 'Adiarsa Timur'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const FieldLabel('Alamat Email'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'nama@email.com'),
          const SizedBox(height: 18),
          const FieldLabel('Kata Sandi'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'Minimal 8 karakter', obscure: true),
        ],
      ),
      bottomNavigationBar: BottomActions(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                label: 'Buat Akun',
                onTap: () => Navigator.pushNamed(
                    context, _peran == 0 ? R.wDash : R.pDash),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                        color: AppColors.inkMuted, fontSize: 14),
                    children: const [
                      TextSpan(text: 'Sudah punya akun? '),
                      TextSpan(
                          text: 'Masuk',
                          style: TextStyle(
                              color: AppColors.emerald,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.merk50 : AppColors.putih,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.merk500 : AppColors.slate200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.emerald : AppColors.bg,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(icon,
                      size: 20,
                      color: selected ? Colors.white : AppColors.inkMuted),
                ),
                const Spacer(),
                if (selected)
                  const Icon(LucideIcons.circleCheck,
                      color: AppColors.emerald, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            const SizedBox(height: 3),
            Text(subtitle,
                style: const TextStyle(
                    color: AppColors.inkMuted, fontSize: 12, height: 1.3)),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String value;
  const _LabeledField(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label),
        const SizedBox(height: 8),
        AppTextField(hint: label, value: value),
      ],
    );
  }
}

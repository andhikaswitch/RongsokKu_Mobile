import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class MasukScreen extends StatefulWidget {
  const MasukScreen({super.key});

  @override
  State<MasukScreen> createState() => _MasukScreenState();
}

class _MasukScreenState extends State<MasukScreen> {
  int _peran = 0; // 0 warga, 1 pengepul, 2 admin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Masuk'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Text('Selamat datang kembali 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('Masuk untuk melanjutkan ke akunmu.',
              style: TextStyle(color: AppColors.inkMuted)),
          const SizedBox(height: 24),
          const _Label('Masuk sebagai'),
          const SizedBox(height: 8),
          _RoleSelector(
            value: _peran,
            onChanged: (v) => setState(() => _peran = v),
          ),
          const SizedBox(height: 20),
          const _Label('Email'),
          const SizedBox(height: 8),
          const _Field(hint: 'nama@email.com', icon: Icons.mail_outline),
          const SizedBox(height: 16),
          const _Label('Kata sandi'),
          const SizedBox(height: 8),
          const _Field(hint: '••••••••', icon: Icons.lock_outline, obscure: true),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Masuk',
            onTap: () {
              final tujuan = [R.wDash, R.pDash, R.adDash][_peran];
              Navigator.pushNamed(context, tujuan);
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, R.daftar),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(color: AppColors.inkMuted, fontSize: 14),
                  children: [
                    TextSpan(text: 'Belum punya akun? '),
                    TextSpan(
                        text: 'Daftar sekarang',
                        style: TextStyle(
                            color: AppColors.emerald, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _RoleSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const labels = ['Warga', 'Pengepul', 'Admin'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == value ? AppColors.emerald : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(labels[i],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: i == value ? Colors.white : AppColors.inkMuted)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14));
}

class _Field extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  const _Field({required this.hint, required this.icon, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.inkMuted),
        filled: true,
        fillColor: AppColors.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.emerald, width: 1.6),
        ),
      ),
    );
  }
}

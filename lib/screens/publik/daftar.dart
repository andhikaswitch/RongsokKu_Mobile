import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../../widgets.dart';

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBar('Daftar'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Text('Buat akun baru',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('Gratis, cukup satu menit.',
              style: TextStyle(color: AppColors.inkMuted)),
          const SizedBox(height: 24),
          const FieldLabel('Nama lengkap'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'Nama kamu', icon: Icons.person_outline),
          const SizedBox(height: 16),
          const FieldLabel('Email'),
          const SizedBox(height: 8),
          const AppTextField(hint: 'nama@email.com', icon: Icons.mail_outline),
          const SizedBox(height: 16),
          const FieldLabel('Nomor HP'),
          const SizedBox(height: 8),
          const AppTextField(hint: '08xxxxxxxxxx', icon: Icons.phone_outlined),
          const SizedBox(height: 16),
          const FieldLabel('Kata sandi'),
          const SizedBox(height: 8),
          const AppTextField(hint: '••••••••', icon: Icons.lock_outline, obscure: true),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Buat Akun',
            onTap: () => Navigator.pushNamed(context, R.wDash),
          ),
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, R.masuk),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(color: AppColors.inkMuted, fontSize: 14),
                  children: [
                    TextSpan(text: 'Sudah punya akun? '),
                    TextSpan(
                        text: 'Masuk',
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

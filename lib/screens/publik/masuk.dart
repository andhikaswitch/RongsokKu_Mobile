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
  bool _ingat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            const Align(alignment: Alignment.centerLeft, child: BrandLogo()),
            const SizedBox(height: 24),
            const Text('Selamat datang kembali', style: T.xl),
            const SizedBox(height: 6),
            Text(
              'Masuk untuk melanjutkan penjualan atau penjemputan rongsok.',
              style: T.body.copyWith(color: AppColors.slate500),
            ),
            const SizedBox(height: 28),
            const FieldLabel('Email'),
            const SizedBox(height: 8),
            const AppTextField(hint: 'siti@warga.test'),
            const SizedBox(height: 18),
            const FieldLabel('Kata sandi'),
            const SizedBox(height: 8),
            const AppTextField(hint: '••••••••', obscure: true),
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _ingat = !_ingat),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _ingat ? AppColors.emerald : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _ingat ? AppColors.emerald : AppColors.line,
                              width: 1.6),
                        ),
                        child: _ingat
                            ? const Icon(Icons.check,
                                size: 14, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      const Text('Ingat saya',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text('Lupa sandi?',
                      style: TextStyle(
                          color: AppColors.emerald,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'Masuk',
              onTap: () => Navigator.pushNamed(context, R.wDash),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(child: Divider(color: AppColors.line)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Akun demo',
                      style: TextStyle(
                          color: AppColors.inkMuted, fontSize: 13)),
                ),
                Expanded(child: Divider(color: AppColors.line)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  _DemoRow('Warga', 'siti@warga.test', R.wDash),
                  const Divider(height: 1, color: AppColors.line),
                  _DemoRow('Pengepul', 'hijau@pengepul.test', R.pDash),
                  const Divider(height: 1, color: AppColors.line),
                  _DemoRow('Admin', 'admin@rongsokku.test', R.adDash),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, R.daftar),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                        color: AppColors.inkMuted, fontSize: 14),
                    children: const [
                      TextSpan(text: 'Belum punya akun? '),
                      TextSpan(
                          text: 'Daftar sekarang',
                          style: TextStyle(
                              color: AppColors.emerald,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoRow extends StatelessWidget {
  final String role;
  final String email;
  final String route;
  const _DemoRow(this.role, this.email, this.route);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Text(role,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const Spacer(),
            Text(email,
                style: const TextStyle(
                    color: AppColors.inkMuted, fontSize: 13.5)),
          ],
        ),
      ),
    );
  }
}

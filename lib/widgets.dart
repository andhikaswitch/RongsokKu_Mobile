import 'package:flutter/material.dart';
import 'theme.dart';

/// Tombol utama (emerald, lebar penuh).
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  const PrimaryButton({super.key, required this.label, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.emerald,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
            Text(label),
          ],
        ),
      ),
    );
  }
}

/// Tombol garis (outline).
class OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  const OutlineButton({super.key, required this.label, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.emerald;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: c,
          side: BorderSide(color: c, width: 1.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

/// Kartu putih dengan sudut membulat + bayangan halus.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.line),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Lencana / chip kecil berwarna.
class Pill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  const Pill(this.text, {super.key, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(text,
          style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}

/// Judul bagian + aksi opsional di kanan.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHeader(this.title, {super.key, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!,
                style: const TextStyle(
                    color: AppColors.emerald, fontWeight: FontWeight.w700)),
          ),
      ],
    );
  }
}

/// AppBar dengan panah kembali (meniru "Tombol Kembali" di Figma).
PreferredSizeWidget backBar(String title, {List<Widget>? actions}) {
  return AppBar(
    leading: const BackButton(),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
    actions: actions,
  );
}

/// Label field form.
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14));
}

/// Input teks bergaya RongsokKu.
class AppTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool obscure;
  const AppTextField({super.key, required this.hint, this.icon, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon, color: AppColors.inkMuted),
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

/// Item nav bawah.
class NavItem {
  final IconData icon;
  final String label;
  const NavItem(this.icon, this.label);
}

/// Bottom navigation bar bersama. [onTap] menerima index tujuan.
class AppBottomNav extends StatelessWidget {
  final List<NavItem> items;
  final int current;
  final void Function(int index) onTap;
  const AppBottomNav({
    super.key,
    required this.items,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (int i = 0; i < items.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(items[i].icon,
                            size: 24,
                            color: i == current
                                ? AppColors.emerald
                                : AppColors.inkMuted),
                        const SizedBox(height: 4),
                        Text(items[i].label,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: i == current
                                    ? AppColors.emerald
                                    : AppColors.inkMuted)),
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

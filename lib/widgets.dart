import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'theme.dart';

// ───────────────────────────── Tombol ─────────────────────────────

/// Tombol utama (default merk/600, tinggi 48, radius 12).
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color color;
  final Color fg;
  final bool expand;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.color = AppColors.merk600,
    this.fg = AppColors.putih,
    this.expand = true,
  });

  /// Varian kuning (nilai/500) dengan teks gelap.
  const PrimaryButton.amber({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.expand = true,
  })  : color = AppColors.nilai500,
        fg = AppColors.slate900;

  @override
  Widget build(BuildContext context) {
    final btn = SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: onTap ?? () {},
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: fg,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
            Text(label),
          ],
        ),
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

/// Tombol garis putih (border slate/200).
class OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color color;
  final Color bg;
  final IconData? icon;
  final bool expand;
  const OutlineButton({
    super.key,
    required this.label,
    this.onTap,
    this.color = AppColors.slate900,
    this.bg = AppColors.putih,
    this.icon,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onTap ?? () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          side: const BorderSide(color: AppColors.slate200),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 6)],
            Text(label),
          ],
        ),
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

// ───────────────────────────── Kartu & teks ─────────────────────────────

/// Kartu putih, border slate/200, radius 16.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color color;
  final Color borderColor;
  final double radius;
  final double borderWidth;
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.color = AppColors.putih,
    this.borderColor = AppColors.slate200,
    this.radius = 16,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(radius);
    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: r,
        side: BorderSide(color: borderColor, width: borderWidth),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Lencana / chip kecil.
class Pill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  const Pill(
    this.text, {
    super.key,
    required this.bg,
    required this.fg,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(text,
          style: TextStyle(
              color: fg,
              fontSize: fontSize,
              height: 16 / 12,
              fontWeight: FontWeight.w600)),
    );
  }
}

/// Jenis status permintaan (warna dari variabel status Figma).
enum Tone { sky, violet, orange, merk, rose, slate }

(Color, Color) _tone(Tone t) => switch (t) {
      Tone.sky => (AppColors.sky50, AppColors.sky700),
      Tone.violet => (AppColors.violet50, AppColors.violet700),
      Tone.orange => (AppColors.orange50, AppColors.orange700),
      Tone.merk => (AppColors.merk50, AppColors.merk700),
      Tone.rose => (AppColors.rose50, AppColors.rose700),
      Tone.slate => (AppColors.slate100, AppColors.slate600),
    };

/// Pil status dengan titik di kiri (mis. "● Dijadwalkan").
class StatusPill extends StatelessWidget {
  final String text;
  final Tone tone;
  const StatusPill(this.text, {super.key, required this.tone});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _tone(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(text, style: T.label.copyWith(color: fg)),
        ],
      ),
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
        Text(title, style: T.m),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!,
                style: T.label.copyWith(color: AppColors.merk700)),
          ),
      ],
    );
  }
}

/// Kotak ikon berwarna (mis. ikon 16 di kotak 32 merk/50).
class IconBox extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color bg;
  final Color fg;
  final double radius;
  const IconBox(
    this.icon, {
    super.key,
    this.size = 32,
    this.iconSize = 16,
    this.bg = AppColors.merk50,
    this.fg = AppColors.merk700,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(radius)),
      child: Icon(icon, size: iconSize, color: fg),
    );
  }
}

/// Kotak emoji jenis rongsok (44, slate/50, radius 12).
class EmojiTile extends StatelessWidget {
  final String emoji;
  final double size;
  const EmojiTile(this.emoji, {super.key, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.slate50, borderRadius: BorderRadius.circular(12)),
      child: Text(emoji, style: TextStyle(fontSize: size * 0.45)),
    );
  }
}

/// Garis pemisah tipis slate/100.
class Sep extends StatelessWidget {
  const Sep({super.key});
  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: AppColors.slate100);
}

// ───────────────────────────── Header ─────────────────────────────

/// Tombol kembali: kotak 40 slate/50 radius 12 + panah kiri 20.
class BackBox extends StatelessWidget {
  const BackBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.slate50,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.maybePop(context),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(LucideIcons.arrowLeft, size: 20, color: AppColors.slate900),
        ),
      ),
    );
  }
}

/// Header putih 60px dengan garis bawah (dipakai sebagai appBar).
class _HeaderShell extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> children;
  const _HeaderShell(this.children);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.putih,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.slate200)),
          ),
          child: Row(children: children),
        ),
      ),
    );
  }
}

Widget _titleBlock(String title, String? subtitle) => Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: T.m, maxLines: 1, overflow: TextOverflow.ellipsis),
          if (subtitle != null)
            Text(subtitle,
                style: T.s, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );

/// "Header Kembali": tombol kembali + judul + sub-judul.
PreferredSizeWidget subBar(String title, String? subtitle, {Widget? trailing}) {
  return _HeaderShell([
    const BackBox(),
    const SizedBox(width: 12),
    _titleBlock(title, subtitle),
    if (trailing != null) ...[const SizedBox(width: 12), trailing],
  ]);
}

/// Kompatibilitas lama.
PreferredSizeWidget backBar(String title) => subBar(title, null);

/// "Header Panel": logo + judul + sub-judul + tombol notifikasi.
PreferredSizeWidget panelBar(String title, String subtitle,
    {bool notif = true}) {
  return _HeaderShell([
    const LogoMark(),
    const SizedBox(width: 12),
    _titleBlock(title, subtitle),
    if (notif) const NotifButton(),
  ]);
}

/// Tanda logo: kotak merk/600 dengan ikon daur ulang.
class LogoMark extends StatelessWidget {
  final double size;
  const LogoMark({super.key, this.size = 36});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.merk600,
        borderRadius: BorderRadius.circular(size * 10 / 36),
      ),
      child: Icon(LucideIcons.recycle, color: AppColors.putih, size: size * 22 / 36),
    );
  }
}

/// Tombol lonceng 40 dengan titik merah.
class NotifButton extends StatelessWidget {
  const NotifButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.slate50, borderRadius: BorderRadius.circular(12)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(LucideIcons.bell, size: 20, color: AppColors.slate900),
          Positioned(
            top: 9,
            right: 10,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.rose600,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.slate50, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Wordmark "RongsokKu" (logo + teks dua warna).
class BrandLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  const BrandLogo({super.key, this.iconSize = 36, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoMark(size: iconSize),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.27),
            children: const [
              TextSpan(text: 'Rongsok', style: TextStyle(color: AppColors.slate900)),
              TextSpan(text: 'Ku', style: TextStyle(color: AppColors.merk600)),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────── Form ─────────────────────────────

/// Label field form (Label/S, slate/700).
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) =>
      Text(text, style: T.label.copyWith(color: AppColors.slate700));
}

/// Input teks: tinggi 48, radius 12, border slate/200.
class AppTextField extends StatelessWidget {
  final String hint;
  final String? value;
  final IconData? icon;
  final bool obscure;
  final String? suffix;
  final String? prefix;
  final TextAlign align;
  final bool focused;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  const AppTextField({
    super.key,
    required this.hint,
    this.value,
    this.icon,
    this.obscure = false,
    this.suffix,
    this.prefix,
    this.align = TextAlign.start,
    this.focused = false,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder b(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c, width: w),
        );
    final field = TextFormField(
      controller: controller,
      initialValue: controller == null ? value : null,
      obscureText: obscure,
      textAlign: align,
      keyboardType: keyboardType,
      maxLines: obscure ? 1 : maxLines,
      onChanged: onChanged,
      style: T.body,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: T.body.copyWith(color: AppColors.slate400),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        prefixIcon: icon == null
            ? null
            : Icon(icon, size: 18, color: AppColors.slate400),
        prefixText: prefix,
        prefixStyle: T.body.copyWith(color: AppColors.slate500),
        suffixText: suffix,
        suffixStyle: T.s.copyWith(color: AppColors.slate400),
        filled: true,
        fillColor: AppColors.putih,
        enabledBorder:
            focused ? b(AppColors.merk500, 1.5) : b(AppColors.slate200),
        focusedBorder: b(AppColors.merk500, 1.5),
      ),
    );
    return maxLines > 1 ? field : SizedBox(height: 48, child: field);
  }
}

/// Label + field dalam satu blok (jarak 8 di antaranya).
class LabeledField extends StatelessWidget {
  final String label;
  final Widget field;
  const LabeledField(this.label, this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [FieldLabel(label), const SizedBox(height: 8), field],
    );
  }
}

/// Deretan pil pilihan yang membungkus ke baris berikutnya (satu aktif).
class ChoicePills extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelected;
  const ChoicePills({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (int i = 0; i < items.length; i++)
          GestureDetector(
            onTap: () => onSelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: i == selected ? AppColors.merk600 : AppColors.putih,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                    color:
                        i == selected ? AppColors.merk600 : AppColors.slate200),
              ),
              child: Text(items[i],
                  style: T.label.copyWith(
                      color: i == selected
                          ? AppColors.putih
                          : AppColors.slate600)),
            ),
          ),
      ],
    );
  }
}

// ───────────────────────────── CRUD helper ─────────────────────────────

/// Dialog konfirmasi (dipakai untuk aksi Hapus / Batalkan / Nonaktifkan).
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirm = 'Hapus',
  bool danger = true,
  IconData icon = LucideIcons.trash2,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: AppColors.putih,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconBox(icon,
                size: 48,
                iconSize: 22,
                radius: 14,
                bg: danger ? AppColors.rose50 : AppColors.merk50,
                fg: danger ? AppColors.rose600 : AppColors.merk700),
            const SizedBox(height: 14),
            Text(title, style: T.m, textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(message,
                style: T.s.copyWith(color: AppColors.slate600),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlineButton(
                      label: 'Batal', onTap: () => Navigator.pop(ctx, false)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    label: confirm,
                    color: danger ? AppColors.rose600 : AppColors.merk600,
                    onTap: () => Navigator.pop(ctx, true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return ok ?? false;
}

/// Notifikasi singkat di bawah layar.
void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.slate900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(message, style: T.s.copyWith(color: AppColors.putih)),
    ));
}

/// Tombol ikon kecil di baris daftar (edit / hapus).
class RowAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool danger;
  const RowAction(this.icon, {super.key, required this.onTap, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: danger ? AppColors.rose50 : AppColors.slate50,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          width: 34,
          height: 34,
          child: Icon(icon,
              size: 16,
              color: danger ? AppColors.rose600 : AppColors.slate600),
        ),
      ),
    );
  }
}

/// Item menu (layar "Lainnya").
class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool danger;
  final String? tag;
  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.danger = false,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            IconBox(icon,
                size: 36,
                bg: danger ? AppColors.rose50 : AppColors.merk50,
                fg: danger ? AppColors.rose600 : AppColors.merk700),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: T.bodyBold.copyWith(
                          color: danger ? AppColors.rose600 : null)),
                  if (subtitle != null) Text(subtitle!, style: T.s),
                ],
              ),
            ),
            if (tag != null) ...[
              Pill(tag!,
                  bg: AppColors.slate100, fg: AppColors.slate600, fontSize: 10),
              const SizedBox(width: 6),
            ],
            if (!danger)
              const Icon(LucideIcons.chevronRight,
                  size: 18, color: AppColors.slate400),
          ],
        ),
      ),
    );
  }
}

/// Tampilan kosong (daftar tanpa isi).
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const EmptyState(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          IconBox(icon,
              size: 52,
              iconSize: 24,
              radius: 16,
              bg: AppColors.slate100,
              fg: AppColors.slate400),
          const SizedBox(height: 12),
          Text(title, style: T.bodyBold),
          const SizedBox(height: 2),
          Text(subtitle, style: T.s, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// Baris barang dengan stepper jumlah kg (dipakai di Ajukan & Edit Permintaan).
class QtyItemRow extends StatelessWidget {
  final String emoji;
  final String name;
  final int price;
  final int qty;
  final ValueChanged<int> onChanged;
  const QtyItemRow({
    super.key,
    required this.emoji,
    required this.name,
    required this.price,
    required this.qty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final active = qty > 0;
    Widget btn(String t, bool filled, VoidCallback onTap) => InkWell(
          onTap: onTap,
          child: Container(
            width: 32,
            height: 34,
            alignment: Alignment.center,
            color: filled ? AppColors.merk600 : Colors.transparent,
            child: Text(t,
                style: T.bodyBold.copyWith(
                    color: filled ? AppColors.putih : AppColors.slate700)),
          ),
        );
    return AppCard(
      borderColor: active ? AppColors.merk200 : AppColors.slate200,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          EmojiTile(emoji),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: T.bodyBold),
                const SizedBox(height: 2),
                Text('${rupiah(price)} /kg',
                    style: T.s.copyWith(color: AppColors.nilai700)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.putih,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.slate200),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                btn('−', false, () => onChanged(qty > 0 ? qty - 1 : 0)),
                SizedBox(
                  width: 52,
                  height: 34,
                  child: Center(
                    child: Text('$qty kg',
                        style: T.label.copyWith(color: AppColors.slate700)),
                  ),
                ),
                btn('+', active, () => onChanged(qty + 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pemilih tanggal jemput (5 hari ke depan).
class DayPicker extends StatelessWidget {
  static const days = [
    ('Kam', '2'),
    ('Jum', '3'),
    ('Sab', '4'),
    ('Min', '5'),
    ('Sen', '6'),
  ];
  final int selected;
  final ValueChanged<int> onSelected;
  const DayPicker({super.key, required this.selected, required this.onSelected});

  /// Label lengkap, mis. "Sab, 4 Okt".
  static String label(int i) => '${days[i].$1}, ${days[i].$2} Okt';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < days.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => onSelected(i),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: i == selected ? AppColors.merk600 : AppColors.putih,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: i == selected
                          ? AppColors.merk600
                          : AppColors.slate200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(days[i].$1,
                        style: T.s.copyWith(
                            color: i == selected
                                ? AppColors.merk100
                                : AppColors.slate500)),
                    Text(days[i].$2,
                        style: T.m.copyWith(
                            color: i == selected
                                ? AppColors.putih
                                : AppColors.slate900)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Pelacak status 5 langkah. [current] 1..5; langkah aktif berwarna [activeColor].
class StatusTracker extends StatelessWidget {
  static const labels = ['Diajukan', 'Dijadwal', 'Dijemput', 'Ditimbang', 'Selesai'];
  final int current;
  final Color activeColor;
  const StatusTracker(
      {super.key, required this.current, this.activeColor = AppColors.violet600});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 1; i <= labels.length; i++)
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < current
                        ? AppColors.merk600
                        : i == current
                            ? activeColor
                            : AppColors.slate100,
                  ),
                  child: i < current
                      ? const Icon(LucideIcons.check,
                          size: 14, color: AppColors.putih)
                      : Text('$i',
                          style: T.label.copyWith(
                              color: i == current
                                  ? AppColors.putih
                                  : AppColors.slate400)),
                ),
                const SizedBox(height: 6),
                Text(labels[i - 1],
                    style: T.xs.copyWith(
                        color: i <= current
                            ? AppColors.slate700
                            : AppColors.slate400)),
              ],
            ),
          ),
      ],
    );
  }
}

/// Baris dengan judul, keterangan, dan switch.
class SwitchRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const SwitchRow({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: T.bodyBold),
              if (subtitle != null) Text(subtitle!, style: T.s),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          thumbColor: WidgetStateProperty.all(AppColors.putih),
          activeTrackColor: AppColors.merk600,
          inactiveTrackColor: AppColors.slate200,
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }
}

/// Baris kunci–nilai (label kiri abu-abu, nilai kanan tebal).
class KeyValue extends StatelessWidget {
  final String k;
  final String v;
  const KeyValue(this.k, this.v, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(k, style: T.s),
          const SizedBox(width: 12),
          Expanded(child: Text(v, textAlign: TextAlign.right, style: T.label)),
        ],
      ),
    );
  }
}

/// Format "Rp 38.500".
String rupiah(int v) {
  final neg = v < 0;
  final s = v.abs().toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return '${neg ? '− ' : ''}Rp $buf';
}

// ───────────────────────────── Navigasi ─────────────────────────────

/// Item nav bawah.
class NavItem {
  final IconData icon;
  final String label;
  const NavItem(this.icon, this.label);
}

/// Pindah tab nav bawah tanpa merusak tumpukan rute: dashboard [home] selalu
/// tetap di bawah tab lain, sehingga tombol back sistem kembali ke dashboard,
/// lalu ke layar sebelum dashboard (mis. Masuk).
void goTab(BuildContext context, String route, String home) {
  final nav = Navigator.of(context);
  final current = ModalRoute.of(context)?.settings.name;
  if (route == current) return;
  if (route == home) {
    var found = false;
    nav.popUntil((r) {
      if (r.settings.name == home) found = true;
      return found || r.isFirst;
    });
    if (!found) nav.pushReplacementNamed(home);
  } else if (current == home) {
    nav.pushNamed(route);
  } else {
    nav.pushReplacementNamed(route);
  }
}

/// Nav bawah: ikon 22 dalam pil (aktif merk/50), label 10 semibold.
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
        color: AppColors.putih,
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
          child: Row(
            children: [
              for (int i = 0; i < items.length; i++)
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onTap(i),
                    child: SizedBox(
                      height: 56,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: i == current
                                  ? AppColors.merk50
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Icon(items[i].icon,
                                size: 22,
                                color: i == current
                                    ? AppColors.merk700
                                    : AppColors.slate500),
                          ),
                          const SizedBox(height: 4),
                          Text(items[i].label,
                              style: T.xs.copyWith(
                                  color: i == current
                                      ? AppColors.merk700
                                      : AppColors.slate500)),
                        ],
                      ),
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

/// Panel aksi bawah putih dengan garis atas.
class BottomActions extends StatelessWidget {
  final Widget child;
  const BottomActions({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.putih,
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: child,
        ),
      ),
    );
  }
}

// ───────────────────────────── Lain-lain ─────────────────────────────

/// Ikon centang perisai hijau (pengepul terverifikasi).
class VerifiedBadge extends StatelessWidget {
  final bool showText;
  const VerifiedBadge({super.key, this.showText = false});

  @override
  Widget build(BuildContext context) {
    if (!showText) {
      return const Icon(LucideIcons.shieldCheck,
          size: 16, color: AppColors.merk600);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: AppColors.merk50, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.shieldCheck,
              size: 12, color: AppColors.merk700),
          const SizedBox(width: 4),
          Text('Terverifikasi',
              style: T.xs.copyWith(color: AppColors.merk700)),
        ],
      ),
    );
  }
}

/// Avatar inisial berbentuk kotak membulat (mis. "HK").
class InitialAvatar extends StatelessWidget {
  final String text;
  final double size;
  final Color bg;
  final Color fg;
  final bool circle;
  const InitialAvatar(
    this.text, {
    super.key,
    this.size = 48,
    this.bg = AppColors.merk50,
    this.fg = AppColors.merk700,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(size * 0.25),
      ),
      child: Text(text,
          style: TextStyle(
              color: fg, fontWeight: FontWeight.w700, fontSize: size * 0.33)),
    );
  }
}

/// Deretan pil saring (satu aktif).
class FilterChips extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelected;
  final Map<int, IconData> icons;
  final Map<int, String> badges;
  const FilterChips({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.icons = const {},
    this.badges = const {},
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++)
            Padding(
              padding: EdgeInsets.only(right: i == items.length - 1 ? 0 : 8),
              child: GestureDetector(
                onTap: () => onSelected(i),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: i == selected ? AppColors.merk600 : AppColors.putih,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                        color: i == selected
                            ? AppColors.merk600
                            : AppColors.slate200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icons[i] != null) ...[
                        Icon(icons[i],
                            size: 14,
                            color: i == selected
                                ? AppColors.putih
                                : AppColors.slate600),
                        const SizedBox(width: 6),
                      ],
                      Text(items[i],
                          style: T.label.copyWith(
                              color: i == selected
                                  ? AppColors.putih
                                  : AppColors.slate600)),
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

/// Bar progres metrik (mis. Kepatuhan harga 96%).
class MetricBar extends StatelessWidget {
  final String label;
  final int percent;
  final Color color;
  const MetricBar({
    super.key,
    required this.label,
    required this.percent,
    this.color = AppColors.merk600,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: T.s.copyWith(color: AppColors.slate600)),
            Text('$percent%', style: T.label),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: percent / 100,
            minHeight: 6,
            backgroundColor: AppColors.slate100,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

/// Indikator tren harga: ▲ naik (hijau), ▼ turun (merah), atau "stabil".
class TrendText extends StatelessWidget {
  final double percent; // 0 = stabil
  const TrendText(this.percent, {super.key});

  @override
  Widget build(BuildContext context) {
    if (percent == 0) {
      return Text('stabil', style: T.xs.copyWith(color: AppColors.slate400));
    }
    final up = percent > 0;
    final c = up ? AppColors.merk600 : AppColors.rose600;
    final v = percent.abs().toStringAsFixed(1).replaceAll('.', ',');
    return Text('${up ? '▲' : '▼'} $v%', style: T.xs.copyWith(color: c));
  }
}

/// Indikator 3 langkah pengajuan. [current] = 1..3.
class StepIndicator extends StatelessWidget {
  final int current;
  final List<String> labels;
  const StepIndicator({super.key, required this.current, required this.labels});

  @override
  Widget build(BuildContext context) {
    final parts = <Widget>[];
    for (int i = 1; i <= labels.length; i++) {
      final done = i < current;
      final active = i == current;
      parts.add(Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done
              ? AppColors.merk100
              : active
                  ? AppColors.merk600
                  : AppColors.slate100,
        ),
        child: done
            ? const Icon(LucideIcons.check, size: 14, color: AppColors.merk700)
            : Text('$i',
                style: T.label.copyWith(
                    color: active ? AppColors.putih : AppColors.slate400)),
      ));
      if (active) {
        parts.add(const SizedBox(width: 6));
        parts.add(Text(labels[i - 1], style: T.label));
      }
      if (i < labels.length) {
        parts.add(const SizedBox(width: 6));
        parts.add(Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: i < current ? AppColors.merk500 : AppColors.slate200,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ));
        parts.add(const SizedBox(width: 6));
      }
    }
    return AppCard(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: parts),
    );
  }
}

/// Kotak info berwarna dengan ikon (kuning/biru/merah).
class InfoBox extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String text;
  final Color bg;
  final Color fg;
  final Color? textColor;
  const InfoBox({
    super.key,
    required this.icon,
    required this.text,
    this.title,
    this.bg = AppColors.nilai50,
    this.fg = AppColors.nilai700,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(icon, size: 16, color: fg),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title!, style: T.label.copyWith(color: fg)),
                  const SizedBox(height: 2),
                ],
                Text(text, style: T.s.copyWith(color: textColor ?? fg)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu permintaan: kode + status, judul, jadwal, lalu ringkasan & nilai.
class RequestCard extends StatelessWidget {
  final String code;
  final String status;
  final Tone tone;
  final String title;
  final String schedule;
  final String summary;
  final String amount;
  final VoidCallback? onTap;
  const RequestCard({
    super.key,
    required this.code,
    required this.status,
    required this.tone,
    required this.title,
    required this.schedule,
    required this.summary,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(code, style: T.label.copyWith(color: AppColors.slate500)),
              StatusPill(status, tone: tone),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: T.bodyBold),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(LucideIcons.calendar,
                  size: 14, color: AppColors.slate500),
              const SizedBox(width: 6),
              Text(schedule, style: T.s),
            ],
          ),
          const SizedBox(height: 10),
          const Sep(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(summary, style: T.s.copyWith(color: AppColors.slate600)),
              Text(amount,
                  style: T.bodyBold.copyWith(color: AppColors.nilai700)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Grafik garis kecil (sparkline) dengan area gradien opsional.
class Sparkline extends StatelessWidget {
  final List<double> points;
  final Color color;
  final double height;
  final bool fill;
  const Sparkline({
    super.key,
    required this.points,
    this.color = AppColors.nilai500,
    this.height = 40,
    this.fill = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _SparkPainter(points, color, fill)),
    );
  }
}

class _SparkPainter extends CustomPainter {
  final List<double> pts;
  final Color color;
  final bool fill;
  _SparkPainter(this.pts, this.color, this.fill);

  @override
  void paint(Canvas canvas, Size size) {
    if (pts.length < 2) return;
    final lo = pts.reduce((a, b) => a < b ? a : b);
    final hi = pts.reduce((a, b) => a > b ? a : b);
    final span = (hi - lo) == 0 ? 1 : hi - lo;
    final dx = size.width / (pts.length - 1);
    final path = Path();
    for (int i = 0; i < pts.length; i++) {
      final x = dx * i;
      final y = size.height - 2 - (pts[i] - lo) / span * (size.height - 4);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    if (fill) {
      final area = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(
        area,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.35), color.withValues(alpha: 0)],
          ).createShader(Offset.zero & size),
      );
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _SparkPainter old) => old.pts != pts;
}

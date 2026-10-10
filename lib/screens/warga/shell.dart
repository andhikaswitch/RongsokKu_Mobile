import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../widgets.dart';

const _items = [
  NavItem(LucideIcons.house, 'Beranda'),
  NavItem(LucideIcons.plus, 'Ajukan'),
  NavItem(LucideIcons.truck, 'Permintaan'),
  NavItem(LucideIcons.search, 'Cari'),
  NavItem(LucideIcons.menu, 'Lainnya'),
];

const _routes = [R.wDash, R.a1, R.wRinci, R.cari, R.dampak];

/// Bottom nav untuk area Warga. [current] = index tab aktif.
Widget wargaNav(BuildContext context, int current) {
  return AppBottomNav(
    items: _items,
    current: current,
    onTap: (i) {
      // Ajukan, Permintaan & Cari adalah layar detail tanpa nav: cukup push.
      if (i == 1 || i == 2 || i == 3) {
        Navigator.pushNamed(context, _routes[i]);
      } else {
        goTab(context, _routes[i], R.wDash);
      }
    },
  );
}

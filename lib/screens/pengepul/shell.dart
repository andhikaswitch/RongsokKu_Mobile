import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../widgets.dart';

const _items = [
  NavItem(LucideIcons.house, 'Beranda'),
  NavItem(LucideIcons.bell, 'Masuk'),
  NavItem(LucideIcons.zap, 'Terbuka'),
  NavItem(LucideIcons.chartLine, 'Harga'),
  NavItem(LucideIcons.menu, 'Lainnya'),
];

const _routes = [R.pDash, R.pMasuk, R.terbuka, R.harga, R.pMenu];

/// Bottom nav untuk area Pengepul.
Widget pengepulNav(BuildContext context, int current) {
  return AppBottomNav(
    items: _items,
    current: current,
    onTap: (i) {
      // Pusat Harga adalah layar publik tanpa nav: cukup push.
      if (i == 3) {
        Navigator.pushNamed(context, _routes[i]);
      } else {
        goTab(context, _routes[i], R.pDash);
      }
    },
  );
}

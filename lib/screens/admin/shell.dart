import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../routes.dart';
import '../../widgets.dart';

const _items = [
  NavItem(LucideIcons.house, 'Beranda'),
  NavItem(LucideIcons.shieldCheck, 'Verifikasi'),
  NavItem(LucideIcons.wallet, 'Top-up'),
  NavItem(LucideIcons.truck, 'Transaksi'),
  NavItem(LucideIcons.menu, 'Lainnya'),
];

/// Bottom nav untuk area Admin.
Widget adminNav(BuildContext context, int current) {
  return AppBottomNav(
    items: _items,
    current: current,
    onTap: (i) {
      switch (i) {
        case 0:
          goTab(context, R.adDash, R.adDash);
        case 1:
          Navigator.pushNamed(context, R.verif);
        case 2:
          goTab(context, R.topup, R.adDash);
        case 3:
          Navigator.pushNamed(context, R.sengketa);
        case 4:
          goTab(context, R.adMenu, R.adDash);
      }
    },
  );
}

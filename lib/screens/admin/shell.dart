import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../widgets.dart';

const _items = [
  NavItem(Icons.dashboard_rounded, 'Beranda'),
  NavItem(Icons.verified_rounded, 'Verifikasi'),
  NavItem(Icons.account_balance_wallet_rounded, 'Top-up'),
  NavItem(Icons.gavel_rounded, 'Sengketa'),
  NavItem(Icons.logout_rounded, 'Keluar'),
];

const _routes = [R.adDash, R.verif, R.verif, R.sengketa, R.beranda];

/// Bottom nav untuk area Admin.
Widget adminNav(BuildContext context, int current) {
  return AppBottomNav(
    items: _items,
    current: current,
    onTap: (i) {
      if (i == current) return;
      if (i == 4) {
        Navigator.pushNamedAndRemoveUntil(context, R.beranda, (r) => false);
      } else {
        Navigator.pushReplacementNamed(context, _routes[i]);
      }
    },
  );
}

import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../widgets.dart';

const _items = [
  NavItem(Icons.home_rounded, 'Beranda'),
  NavItem(Icons.inbox_rounded, 'Masuk'),
  NavItem(Icons.explore_rounded, 'Terbuka'),
  NavItem(Icons.trending_up_rounded, 'Harga'),
  NavItem(Icons.account_balance_wallet_rounded, 'Dompet'),
];

const _routes = [R.pDash, R.pMasuk, R.terbuka, R.harga, R.dompet];

/// Bottom nav untuk area Pengepul.
Widget pengepulNav(BuildContext context, int current) {
  return AppBottomNav(
    items: _items,
    current: current,
    onTap: (i) {
      if (i == current) return;
      Navigator.pushReplacementNamed(context, _routes[i]);
    },
  );
}

import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../widgets.dart';

const _items = [
  NavItem(Icons.home_rounded, 'Beranda'),
  NavItem(Icons.add_box_rounded, 'Ajukan'),
  NavItem(Icons.receipt_long_rounded, 'Riwayat'),
  NavItem(Icons.search_rounded, 'Cari'),
  NavItem(Icons.eco_rounded, 'Dampak'),
];

const _routes = [R.wDash, R.a1, R.wRinci, R.cari, R.dampak];

/// Bottom nav untuk area Warga. [current] = index tab aktif.
Widget wargaNav(BuildContext context, int current) {
  return AppBottomNav(
    items: _items,
    current: current,
    onTap: (i) {
      if (i == current) return;
      Navigator.pushReplacementNamed(context, _routes[i]);
    },
  );
}

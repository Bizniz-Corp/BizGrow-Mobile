import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah indeks yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: Colors.(#151436),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('lib/assets/navbar_icon/default/Beranda.png'),
            size: 24,
          ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('lib/assets/navbar_icon/default/Penjualan.png'),
            size: 24,
          ),
          label: 'Penjualan',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('lib/assets/navbar_icon/default/Stok.png'),
            size: 24,
          ),
          label: 'Stok',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('lib/assets/navbar_icon/default/Profil.png'),
            size: 24,
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}

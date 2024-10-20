import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/styles/colors.dart';

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
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: MainColors.blueSecondary,
            width: 8
          )
        )
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MainColors.darkBlue,
        selectedItemColor: Monochrome.whiteDarkMode,
        unselectedItemColor: Monochrome.lightGrey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _selectedIndex == 0? 
                'lib/assets/navbar_icon/selected/Beranda.png' : 'lib/assets/navbar_icon/default/Beranda.png',
              ),
              size: 24,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _selectedIndex == 1? 
                'lib/assets/navbar_icon/selected/Penjualan.png' : 'lib/assets/navbar_icon/default/Penjualan.png',
              ),
              size: 24,
            ),
            label: 'Penjualan',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _selectedIndex == 2? 
                'lib/assets/navbar_icon/selected/Stok.png' : 'lib/assets/navbar_icon/default/Stok.png',
              ),
              size: 24,
            ),
            label: 'Stok',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _selectedIndex == 3? 
                'lib/assets/navbar_icon/selected/Profil.png' : 'lib/assets/navbar_icon/default/Profil.png',
              ),
              size: 24,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

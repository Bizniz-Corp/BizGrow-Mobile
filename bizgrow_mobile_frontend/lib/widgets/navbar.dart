import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/profil_screen.dart';

class MainNavigator extends StatefulWidget {
  final int selectedIndex;

  const MainNavigator({super.key, required this.selectedIndex});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BerandaScreen(),
    PenjualanScreen(),
    StokScreen(),
    ProfilScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex; // Set index sesuai parameter yang diberikan
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Main.darkBlue,
        border: Border(
          top: BorderSide(
            color: Main.blueSecondary,
            width: 8,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),

      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Main.darkBlue,
        selectedItemColor: Monochrome.whiteDarkMode,
        unselectedItemColor: Monochrome.lightGrey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _currentIndex == 0
                    ? 'lib/assets/navbar_icon/selected/Beranda.png'
                    : 'lib/assets/navbar_icon/default/Beranda.png',
              ),
              size: 24,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _currentIndex == 1
                    ? 'lib/assets/navbar_icon/selected/Penjualan.png'
                    : 'lib/assets/navbar_icon/default/Penjualan.png',
              ),
              size: 24,
            ),
            label: 'Penjualan',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _currentIndex == 2
                    ? 'lib/assets/navbar_icon/selected/Stok.png'
                    : 'lib/assets/navbar_icon/default/Stok.png',
              ),
              size: 24,
            ),
            label: 'Stok',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                _currentIndex == 3
                    ? 'lib/assets/navbar_icon/selected/Profil.png'
                    : 'lib/assets/navbar_icon/default/Profil.png',
              ),
              size: 24,
            ),
            label: 'Profil',
          ),
        ],
      )
    );
  }
}
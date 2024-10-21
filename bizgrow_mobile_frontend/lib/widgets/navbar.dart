import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/screens/beranda/beranda_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/penjualan/penjualan_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/stok/stok_screen.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/profil_screen.dart';

class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah indeks yang dipilih
    });
    _pageController.jumpToPage(index);

    // Menentukan navigasi berdasarkan indeks yang dipilih
    // switch (index) {
    //   case 0:
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => BerandaScreen()),
    //     );
    //     break;
    //   case 1:
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => PenjualanScreen()),
    //     );
    //     break;
    //   case 2:
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => StokScreen()),
    //     );
    //     break;
    //   case 3:
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => ProfilScreen()),
    //     );
    //     break;
    // }

  }

  final List<Widget> _pages = [
    BerandaScreen(),
    PenjualanScreen(),
    StokScreen(),
    ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 80,
    //   decoration: BoxDecoration(
    //     border: const Border(
    //       top: BorderSide(
    //         color: Main.blueSecondary,
    //         width: 8,
    //       ),
    //     ),
    //   ),
    //   child: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     backgroundColor: Main.darkBlue,
    //     selectedItemColor: Monochrome.whiteDarkMode,
    //     unselectedItemColor: Monochrome.lightGrey,
    //     currentIndex: _selectedIndex,
    //     onTap: _onItemTapped,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //             _selectedIndex == 0
    //                 ? 'lib/assets/navbar_icon/selected/Beranda.png'
    //                 : 'lib/assets/navbar_icon/default/Beranda.png',
    //           ),
    //           size: 24,
    //         ),
    //         label: 'Beranda',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //             _selectedIndex == 1
    //                 ? 'lib/assets/navbar_icon/selected/Penjualan.png'
    //                 : 'lib/assets/navbar_icon/default/Penjualan.png',
    //           ),
    //           size: 24,
    //         ),
    //         label: 'Penjualan',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //             _selectedIndex == 2
    //                 ? 'lib/assets/navbar_icon/selected/Stok.png'
    //                 : 'lib/assets/navbar_icon/default/Stok.png',
    //           ),
    //           size: 24,
    //         ),
    //         label: 'Stok',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //             _selectedIndex == 3
    //                 ? 'lib/assets/navbar_icon/selected/Profil.png'
    //                 : 'lib/assets/navbar_icon/default/Profil.png',
    //           ),
    //           size: 24,
    //         ),
    //         label: 'Profil',
    //       ),
    //     ],
    //   ),
    // );
  
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),

      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          border: const Border(
            top: BorderSide(
              color: Main.blueSecondary,
              width: 8,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Main.darkBlue,
          selectedItemColor: Monochrome.whiteDarkMode,
          unselectedItemColor: Monochrome.lightGrey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  _selectedIndex == 0
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
                  _selectedIndex == 1
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
                  _selectedIndex == 2
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
                  _selectedIndex == 3
                      ? 'lib/assets/navbar_icon/selected/Profil.png'
                      : 'lib/assets/navbar_icon/default/Profil.png',
                ),
                size: 24,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }
}

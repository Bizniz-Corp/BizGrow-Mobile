import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget{
    @override
    _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator>{

    int _selectedIndex = 0;

    // List<Widget> _screens = [
    //     BerandaScreen(),
    //     PenjualanScreen(),
    //     StokScreen(),
    //     ProfilScreen(),
    // ];

    @override
    Widget build(BuildContext context){
        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), 
                        label: 'Beranda'
                    )
            ]),
        );
    }
}
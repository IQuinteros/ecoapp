import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class EcoAppBottomBar extends StatefulWidget {
  @override
  _EcoAppBottomBarState createState() => _EcoAppBottomBarState();
}

class _EcoAppBottomBarState extends State<EcoAppBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: EcoAppColors.MAIN_COLOR,
      selectedItemColor: EcoAppColors.ACCENT_COLOR,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 20.0,
      iconSize: 30.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedLabelStyle: GoogleFonts.montserrat(),
      unselectedLabelStyle: GoogleFonts.montserrat(),
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.shopping_cart),
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart'
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.history),
          icon: Icon(Icons.history),
          label: 'History'
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.account_circle),
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile'
        )
      ],
    );
  }
}
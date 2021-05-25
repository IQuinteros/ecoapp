import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoBottomNavigationBar extends StatelessWidget {

  final Function(int) onTap;
  final int currentIndex;

  const EcoBottomNavigationBar({Key key, this.onTap, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10.0
          )
        ]
      ),
      child: BottomNavigationBar(
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
        currentIndex: currentIndex,
        onTap: (value){
          onTap(value);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
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
      ),
    );
  }
}
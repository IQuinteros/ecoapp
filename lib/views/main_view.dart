import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/cart_view.dart';
import 'package:flutter_ecoapp/views/history_view.dart';
import 'package:flutter_ecoapp/views/home_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';



class MainView extends StatefulWidget {

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContent(context),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getContent(BuildContext context){
    switch (currentIndex) {
      case 0: return HomeView();
      case 1: return CartView();
      case 2: return HistoryView();
      default: return HomeView();
    }
  }

  Widget getBottomNavigationBar(){
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
      currentIndex: currentIndex,
      onTap: (value){
        setState(() {
          currentIndex = value;
        });
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
    );
  }
  
}
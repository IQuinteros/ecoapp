import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/cart_view.dart';
import 'package:flutter_ecoapp/views/history_view.dart';
import 'package:flutter_ecoapp/views/home_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
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
      body: SafeArea(child: getContent(context)),
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
    return EcoBottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value){
        setState(() {
          currentIndex = value;
        });
      },
    );
  }
  
}
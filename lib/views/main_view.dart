import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/views/cart_view.dart';
import 'package:flutter_ecoapp/views/history_view.dart';
import 'package:flutter_ecoapp/views/home_view.dart';
import 'package:flutter_ecoapp/views/profile_view.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';

class MainView extends StatefulWidget {

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavBar = EcoBottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value){
        setState(() {
          currentIndex = value;
        });
      },
    );

    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.mainEcoNavBar = bottomNavBar;

    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.loadCart();

    return Scaffold(
      body: SafeArea(child: getContent(context)),
      bottomNavigationBar: bottomNavBar
    );
  }

  Widget getContent(BuildContext context){
    switch (currentIndex) {
      case 0: return HomeView();
      case 1: return CartView();
      case 2: return HistoryView();
      case 3: return ProfileView();
      default: return HomeView();
    }
  }
  
}
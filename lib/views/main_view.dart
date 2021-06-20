import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';
import 'package:flutter_ecoapp/views/cart_view.dart';
import 'package:flutter_ecoapp/views/error_network_view.dart';
import 'package:flutter_ecoapp/views/history_view.dart';
import 'package:flutter_ecoapp/views/home_view.dart';
import 'package:flutter_ecoapp/views/profile_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';

class MainView extends StatefulWidget {

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  bool errorDisplaying = false;

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

    BaseAPI.staticOnFailConnect = (reason) async {
      print('STOP');
      if(!errorDisplaying){
        if(reason == FailConnectReason.decoding){
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Ha ocurrido un error con nuestros servidores'),
            backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
          ));
          return;
        }
        errorDisplaying = true;
        // Navigator.popUntil(context, ModalRoute.withName('/'));
        //Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));

        await showModalBottomSheet(
          context: context, 
          builder: (BuildContext context){
            return ErrorNetworkModal(reason: reason,);
          },
          isDismissible: false
        );

        //await Navigator.pushReplacementNamed(context, 'errorNetwork', arguments: reason);
        errorDisplaying = false;
      }
    };

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
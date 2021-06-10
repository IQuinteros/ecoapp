import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';

class AppBloc extends BaseBloc<CartModel>{

  AppBloc() : super(0);
  
  late EcoBottomNavigationBar mainEcoNavBar;

  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/providers/sqlite/cart_local_api.dart';

class CartBloc extends BaseBloc<CartModel>{

  final CartLocalAPI cartLocalAPI = CartLocalAPI();

  CartBloc(initialState) : super(initialState);
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
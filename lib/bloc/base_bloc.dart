import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/models/base.dart';

abstract class BaseBloc<T extends BaseModel> extends Bloc{
  BaseBloc(initialState) : super(initialState){
    initializeBloc();
  }

  @override
  Stream mapEventToState(event);

  @override
  Future<void> initializeBloc();
}
import 'package:flutter_ecoapp/bloc/base_bloc.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/providers/category_api.dart';

class CategoryBloc extends BaseBloc<CategoryModel>{

  final categoryAPI = CategoryAPI();

  CategoryBloc(initialState) : super(initialState);

  @override
  Future<void> initializeBloc() async {
    return;
  }

  Future<List<CategoryModel>> getCategories(String search) async => await categoryAPI.selectAll();
  
  @override
  Stream mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/views/result_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class CategoryListItem extends StatelessWidget {

  final CategoryModel category;

  const CategoryListItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      leading: Icon(
        category.getIcon(),
        color: EcoAppColors.MAIN_DARK_COLOR,
      ),
      title: Text(
        category.title
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: EcoAppColors.MAIN_DARK_COLOR,
      ),
      selectedTileColor: EcoAppColors.ACCENT_COLOR,
      onTap: () async {
        var value = await Navigator.push(context, MaterialPageRoute(builder: (__) => ResultView(searching: category.toString(),)));
        if(value != null) appBloc.mainEcoNavBar.onTap(value);
      }
    );
  }
}
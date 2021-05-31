import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/category.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class CategoryListItem extends StatelessWidget {

  final CategoryModel category;

  const CategoryListItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      leading: Icon(
        category.getIcon(),
        color: EcoAppColors.MAIN_COLOR,
      ),
      title: Text(
        category.title
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      selectedTileColor: EcoAppColors.ACCENT_COLOR,
      onTap: (){},
    );
  }
}
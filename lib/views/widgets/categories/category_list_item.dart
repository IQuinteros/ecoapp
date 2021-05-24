import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class CategoryListItem extends StatelessWidget {

  final IconData iconData;
  final String text;

  const CategoryListItem({Key key, this.iconData, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0
      ),
      leading: Icon(
        iconData,
        color: EcoAppColors.MAIN_COLOR,
      ),
      title: Text(
        text
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      selectedTileColor: EcoAppColors.ACCENT_COLOR,
      onTap: (){},
    );
  }
}
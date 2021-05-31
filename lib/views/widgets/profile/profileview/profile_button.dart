import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon, 
        size: 35, 
        color: EcoAppColors.MAIN_COLOR
      ),
      title: Text(title),
      trailing: Icon(
        Icons.keyboard_arrow_right_rounded,
        color: EcoAppColors.MAIN_COLOR,
        size: 30
      ),
      onTap: onTap,
    );
  }
}
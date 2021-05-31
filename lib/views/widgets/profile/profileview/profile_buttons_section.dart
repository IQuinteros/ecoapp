import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_button.dart';

class ProfileButtonsSection extends StatelessWidget {
  const ProfileButtonsSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(thickness: 1),
          ProfileButton(icon: Icons.star_border_rounded, title: 'Lista de favoritos', onTap: (){}),
          Divider(thickness: 1),
          ProfileButton(icon: Icons.history, title: 'Historial', onTap: (){}),
          Divider(thickness: 1),
          ProfileButton(icon: Icons.shopping_cart_outlined, title: 'Mis compras', onTap: (){}),
          Divider(thickness: 1),
          ProfileButton(icon: Icons.settings_outlined, title: 'Ajustes de perfil', onTap: (){}),
          SizedBox(height: 10.0),
        ],
      )
    );
  }
}
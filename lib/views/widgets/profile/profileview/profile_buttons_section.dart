import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/favorites.view.dart';
import 'package:flutter_ecoapp/views/profile_modify_view.dart';
import 'package:flutter_ecoapp/views/purchases_view.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_button.dart';

class ProfileButtonsSection extends StatelessWidget {
  const ProfileButtonsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(thickness: 1),
          ProfileButton(
            icon: Icons.star_border_rounded, 
            title: 'Lista de favoritos', 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => FavoritesView()))
          ),
          Divider(thickness: 1),
          ProfileButton(icon: Icons.history, title: 'Historial', onTap: (){}),
          Divider(thickness: 1),
          ProfileButton(
            icon: Icons.shopping_cart_outlined, 
            title: 'Mis compras', 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => PurchasesView()))
          ),
          Divider(thickness: 1),
          ProfileButton(
            icon: Icons.settings_outlined, 
            title: 'Ajustes de perfil', 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ProfileModifyView()))
          ),
          SizedBox(height: 10.0),
        ],
      )
    );
  }
}
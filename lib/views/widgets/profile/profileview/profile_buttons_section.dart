import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/favorites.view.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/profile_modify_view.dart';
import 'package:flutter_ecoapp/views/purchases_view.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_button.dart';

class ProfileButtonsSection extends StatelessWidget {
  const ProfileButtonsSection({
    Key? key,
    this.profile
  }) : super(key: key);

  final ProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return Container(
      child: Column(
        children: [
          Divider(thickness: 1),
          ProfileButton(icon: Icons.history, title: 'Historial', onTap: (){
            appBloc.mainEcoNavBar.onTap(2);
          }),
          Divider(thickness: 1),
          ProfileButton(
            icon: Icons.star_border_rounded, 
            title: 'Lista de favoritos', 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => profile != null? FavoritesView() : LoginView())),
            subtitle: profile == null? Text(
              'Necesita iniciar sesión'
            ) : null
          ),
          Divider(thickness: 1),
          ProfileButton(
            icon: Icons.shopping_cart_outlined, 
            title: 'Mis compras', 
            onTap: () async {
              var value = await Navigator.push(context, MaterialPageRoute(builder: (__) => profile != null? PurchasesView() : LoginView()));
              if(value != null) appBloc.mainEcoNavBar.onTap(value);
            },
            subtitle: profile == null? Text(
              'Necesita iniciar sesión'
            ) : null
          ),
          Divider(thickness: 1),
          ProfileButton(
            icon: Icons.settings_outlined, 
            title: 'Ajustes de perfil', 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => profile != null? ProfileModifyView() : LoginView())),
            subtitle: profile == null? Text(
              'Necesita iniciar sesión'
            ) : null
          ),
          SizedBox(height: 10.0),
        ],
      )
    );
  }
}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/favorites.view.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/profile_modify_view.dart';
import 'package:flutter_ecoapp/views/purchases_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
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
          ProfileButton(
            icon: Icons.star_border_rounded, 
            title: 'Lista de favoritos', 
            onTap: () async {
              var value = await Navigator.push(context, MaterialPageRoute(builder: (__) => profile != null? FavoritesView() : LoginView()));
              if(value != null) appBloc.mainEcoNavBar.onTap(value);
            },
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
          profile != null? Divider(thickness: 1) : Container(),
          profile != null? ProfileButton(icon: Icons.exit_to_app_rounded, title: 'Cerrar sesión', onTap: (){
            _closeSession(context);
          }) : Container(),
          SizedBox(height: 10.0),
        ],
      )
    );
  }

  void _closeSession(BuildContext context)async {
    AwesomeDialog(
      title: 'Cerrar sesión',
      desc: 'Cerrarás sesión en este dispositivo',
      dialogType: DialogType.INFO, 
      animType: AnimType.BOTTOMSLIDE,
      context: context,
      btnOkText: 'Cancelar',
      btnCancelText: 'Aceptar',
      btnOkOnPress: () {},
      btnOkColor: EcoAppColors.MAIN_COLOR,
      btnCancelColor: Colors.black26,
      btnCancelOnPress: () =>  _logout(context),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
    )..show();
  }

  void _logout(BuildContext context) async {
    final loading = AwesomeDialog(
      title: 'Cerrando sesión',
      desc: 'Danos un momento',
      dialogType: DialogType.NO_HEADER, 
      animType: AnimType.BOTTOMSLIDE,
      context: context,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
    )..show();

    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    await profileBloc.logout();

    loading.dismiss();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Se ha cerrado la sesión'),
      backgroundColor: EcoAppColors.LEFT_BAR_COLOR,
    ));
  }
}

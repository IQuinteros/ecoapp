import 'package:flutter/material.dart';

import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';

import 'package:google_fonts/google_fonts.dart';


class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EcoAppTextStyle.getTitle('Mi perfil',
          rightButton: IconButton(
            icon: Icon(Icons.sms_outlined), 
            color: EcoAppColors.MAIN_COLOR,
            iconSize: 35,
            onPressed: (){}
          )
        ),
        mainContent(context)
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }

  Widget mainContent(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 2),
            blurRadius: 5
          )
        ]
      ),
      child: Column(
        children: [
          getProfileCover(),
          getButtons()
        ],
      ),
    );
  }

  Widget getProfileCover(){
    final img = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: Image(
        image: NetworkImage('https://picsum.photos/500/300'),
        fit: BoxFit.cover,
      ),
      width: 100,
      height: 100,
    );

    final content = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Iniciar sesión',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            'Inicia sesión fácilmente y disfruta de una experiencia completa',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: Row(
        children: [
          img,
          SizedBox(width: 20.0,),
          Expanded(child: content)
        ],
      ),
    );
  }

  Widget getButtons(){
    return Container(
      child: Column(
        children: [
          Divider(thickness: 1),
          getButton(
            icon: Icons.star_border_rounded,
            title: 'Lista de favoritos',
            onTap: (){}
          ),
          Divider(thickness: 1),
          getButton(
            icon: Icons.history,
            title: 'Historial',
            onTap: (){}
          ),
          Divider(thickness: 1),
          getButton(
            icon: Icons.shopping_cart_outlined,
            title: 'Mis compras',
            onTap: (){}
          ),
          Divider(thickness: 1),
          getButton(
            icon: Icons.settings_outlined,
            title: 'Ajustes de perfil',
            onTap: (){}
          ),
          SizedBox(height: 10.0),
        ],
      )
    );
  }

  Widget getButton({IconData icon, String title, Function onTap}){
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
      enabled: true,
      onTap: () => onTap,
    );
  }
}
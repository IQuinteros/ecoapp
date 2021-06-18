import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/chats_view.dart';

import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_buttons_section.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_cover_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
            initialData: profileBloc.currentProfile,
            stream: profileBloc.sessionStream,
            builder: (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return getTitle(context, () async {
                    if(!snapshot.hasData || snapshot.data == null){
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Para ver tus conversaciones, primero inicia sesión'),
                        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
                      ));
                    } else{
                      var value = await Navigator.push(context, MaterialPageRoute(builder: (__) => ChatsView()));
                      if(value != null) appBloc.mainEcoNavBar.onTap(value);
                    }
                  });
                default: return getTitle(context, () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Cargando'),
                    backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
                  ));
                });
              }
            }
        ),
        
        _MainContent()
      ],
    );

    return SingleChildScrollView(
      child: column,
      scrollDirection: Axis.vertical,
    );
  }

  Widget getTitle(BuildContext context, Function() onTap){
    return EcoTitle(
      text: 'Mi perfil',
      rightButton: IconButton(
        icon: Icon(Icons.sms_outlined), 
        color: EcoAppColors.MAIN_COLOR,
        iconSize: 35,
        onPressed: onTap
      )
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final profileBloc = BlocProvider.of<ProfileBloc>(context);

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
          ProfileCoverSection(),
          StreamBuilder(
            initialData: profileBloc.currentProfile,
            stream: profileBloc.sessionStream,
            builder: (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return ProfileButtonsSection(
                    profile: snapshot.data,
                  );
                default: return Center(child: CircularProgressIndicator());
              }
            }
          )
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCoverSection extends StatelessWidget {
  const ProfileCoverSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);

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
      width: 80,
      height: 80,
    );

    final streamBuilder = StreamBuilder(
      stream: profileBloc.sessionStream,
      initialData: profileBloc.currentProfile,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot){
        print(snapshot.connectionState);
        switch(snapshot.connectionState){
          case ConnectionState.done:
          case ConnectionState.active:
            return _ProfileCoverContent(profile: snapshot.data);
          default: return Center(child: CircularProgressIndicator());
        }
      },
    );

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: Row(
          children: [
            img,
            SizedBox(width: 20.0,),
            Expanded(child: streamBuilder)
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'login');
      },
    );
  }
}

class _ProfileCoverContent extends StatelessWidget {
  const _ProfileCoverContent({
    Key? key,
    required this.profile
  }) : super(key: key);

  final ProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile == null? 'Iniciar sesión' 
              : profile!.fullName,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            profile == null? 'Inicia sesión fácilmente y disfruta de una experiencia completa'
              : profile!.email,
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}

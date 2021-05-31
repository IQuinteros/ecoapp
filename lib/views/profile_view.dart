import 'package:flutter/material.dart';

import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_buttons_section.dart';
import 'package:flutter_ecoapp/views/widgets/profile/profileview/profile_cover_section.dart';

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
          ProfileCoverSection(),
          ProfileButtonsSection()
        ],
      ),
    );
  }
}


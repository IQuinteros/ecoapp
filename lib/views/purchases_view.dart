import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/purchase_bloc.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:flutter_ecoapp/views/widgets/purchases/purchase_card.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchasesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: getContent(context)),
      bottomNavigationBar: EcoBottomNavigationBar(
        currentIndex: 0,
        unselected: true,
        onTap: (value){
          Navigator.pop(context, value);
        },
      )
    );
  }

  Widget getContent(BuildContext context){
    final purchaseBloc = BlocProvider.of<PurchaseBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);


    final content = Column(
      children: [
        //SearchBar(),
        EcoTitle(
          text: 'Mis compras',
          leftButton: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_rounded),
            color: EcoAppColors.MAIN_COLOR,
            iconSize: 40,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        FutureBuilder(
          future: purchaseBloc.getPurchases(profileBloc.currentProfile!),
          builder: (context, AsyncSnapshot<List<PurchaseModel>> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.done:
                if(!snapshot.hasData || snapshot.data!.length <= 0){
                  return Container(
                    margin: EdgeInsets.only(
                      top: 20.0
                    ),
                    child: Text(
                      'No se han encontrado compras realizadas',
                      style: GoogleFonts.montserrat(),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Column(children: snapshot.data!.map<Widget>((e) => PurchaseCard(purchase: e)).toList(),);
              default: return Center(child: CircularProgressIndicator(),);
            }
          }
        )
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}

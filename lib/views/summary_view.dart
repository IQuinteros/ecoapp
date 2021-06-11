import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/chat_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryView extends StatelessWidget {

  const SummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Terminar compra',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: EcoAppColors.MAIN_COLOR,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(child: getContent(context)),
    );
  }

  Widget getContent(BuildContext context){
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final loadedArticles = cartBloc.loadedArticles;

    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    List<Widget> articles = loadedArticles.map<ArticleCard>((e) => ArticleCard(article: e.article)).toList();

    final profileData = Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                'Datos de compra',
                style: GoogleFonts.montserrat(
                  fontSize: 18
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                'Nombre: ${profileBloc.currentProfile!.fullName}',
                style: GoogleFonts.montserrat(
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                'Dirección: ${profileBloc.currentProfile!.location}',
                style: GoogleFonts.montserrat(
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                'Teléfono: ${profileBloc.currentProfile!.contactNumber}',
                style: GoogleFonts.montserrat(
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 10),
      ],
    );

    final content = Column(
      children: [
        Divider(thickness: 1,),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                'Resumen de artículos',
                style: GoogleFonts.montserrat(
                  fontSize: 18
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
        SizedBox(height: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: articles
        ),
        Divider(thickness: 1),
        SizedBox(height: 10.0),
        profileData,
        Divider(thickness: 1),
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}

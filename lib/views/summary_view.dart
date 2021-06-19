import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/purchase_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/cart.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/articles/mini_eco_indicator.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
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

    CartModel cart = CartModel(
      articles: loadedArticles
    );

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

    final purchaseData = Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                'Total: ${CurrencyUtil.formatToCurrencyString(cart.totalPrice.toInt(), symbol: '\$')}',
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
                'Fecha de compra: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
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
                'Sellos amigables: ',
                style: GoogleFonts.montserrat(
                ),
                textAlign: TextAlign.start,
              ),
            ),
            MiniEcoIndicator(ecoIndicator: cart.summaryEcoIndicator),
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
        SizedBox(height: 10.0),
        purchaseData,
        Divider(thickness: 1),
        SizedBox(height: 10.0),
        Container(
          child: NormalButton(
            text: 'Procesar pedido', 
            onPressed: () async {
              final appBloc = BlocProvider.of<AppBloc>(context);  

              final loading = AwesomeDialog(
                title: 'Procesando pedido',
                desc: 'Estamos enviando tu pedido al vendedor',
                dialogType: DialogType.NO_HEADER, 
                animType: AnimType.BOTTOMSLIDE,
                context: context,
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
              )..show();

              final purchaseBloc = BlocProvider.of<PurchaseBloc>(context);
              final result = await purchaseBloc.newPurchase(cart, profileBloc.currentProfile!);

              loading.dismiss();

              if(result){
                cartBloc.clearCart();
                AwesomeDialog(
                  title: 'Pedido exitoso',
                  desc: 'Has realizado tu pedido exitósamente :)',
                  dialogType: DialogType.SUCCES, 
                  animType: AnimType.BOTTOMSLIDE,
                  context: context,
                  btnOkText: 'Aceptar',
                  btnOkOnPress: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    appBloc.mainEcoNavBar.onTap(0);
                  },
                  onDissmissCallback: (__) {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    appBloc.mainEcoNavBar.onTap(0);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
                )..show();
              }
              else{
                AwesomeDialog(
                  title: 'Algo ha fallado',
                  desc: 'Oh no. Por favor, intenta nuevamente',
                  dialogType: DialogType.ERROR, 
                  animType: AnimType.BOTTOMSLIDE,
                  context: context,
                  btnOkText: 'Aceptar',
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
                )..show();
              }
            },
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 20.0
          ),
        )
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}

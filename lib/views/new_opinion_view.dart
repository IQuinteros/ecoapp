import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/opinion.dart';
import 'package:flutter_ecoapp/models/purchase.dart';
import 'package:flutter_ecoapp/utils/currency_util.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/article_card.dart';
import 'package:flutter_ecoapp/views/widgets/normal_button.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:flutter_ecoapp/views/widgets/stars_row.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOpinionView extends StatefulWidget {
  NewOpinionView({ Key? key, required this.articlePurchase }) : super(key: key);

  final ArticleToPurchase articlePurchase;

  @override
  _NewOpinionViewState createState() => _NewOpinionViewState();
}

class _NewOpinionViewState extends State<NewOpinionView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  int stars = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Añadir reseña',
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CoverOpinionInfo(articlePurchase: widget.articlePurchase),
                  SizedBox(height: 10.0),
                  Divider(thickness: 1,),
                  SizedBox(height: 20.0),
                  Text(
                    'Califica con estrellas',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 18
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Spacer(),
                      StarsRow(
                        rating: 0, 
                        editable: true,
                        onEdit: (value) => stars = value.toInt(),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Divider(thickness: 1,),
                  SizedBox(height: 20.0),
                  NormalInput(
                    header: '¿Qué te pareció el producto?', 
                    hint: 'En pocas palabras', 
                    icon: Icons.comment,
                    controller: titleController,
                    type: TextInputType.text,
                    maxLength: 50,
                    validator: (value) => value == null || value.isEmpty? 'Tu reseña necesita una pequeña opinión' : null,
                  ),
                  NormalInput(
                    header: 'Detalles (opcional)', 
                    hint: '', 
                    icon: Icons.comment,
                    controller: commentController,
                    type: TextInputType.multiline,
                    maxLines: 5,
                    maxLength: 250,
                  ),
                  SizedBox(height: 20.0),
                  NormalButton(
                    text: 'Enviar reseña', 
                    onPressed: (){
                      final validate = _formKey.currentState!.validate();
                      if(stars <= 0){
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Antes, califica con estrellas por favor'),
                          backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
                        ));
                        return;
                      }
                      if(!validate) return;
                      

                      sendOpinion(context);
                    }
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  Future<void> sendOpinion(BuildContext context) async {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    final loading = AwesomeDialog(
      title: 'Subiendo reseña',
      desc: 'Estamos subiendo tus estrellas a las nubes',
      dialogType: DialogType.NO_HEADER, 
      animType: AnimType.BOTTOMSLIDE,
      context: context,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
    )..show();

    final result = await articleBloc.newOpinionToArticle(
      article: widget.articlePurchase.article!, 
      profile: profileBloc.currentProfile!, 
      opinion: OpinionModel(
        id: 0, 
        rating: stars, 
        title: titleController.text,
        content: commentController.text, 
        date: DateTime.now()
      )
    );

    loading.dismiss();

    if(result){
      AwesomeDialog(
        title: 'Reseña enviada',
        desc: 'Gracias por enviar tu opinión. Le servirá a todos :)',
        dialogType: DialogType.SUCCES, 
        animType: AnimType.BOTTOMSLIDE,
        context: context,
        btnOkText: 'Aceptar',
        btnOkOnPress: () {
          Navigator.pop(context);
        },
        onDissmissCallback: (__) {
          Navigator.pop(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
      )..show();
    }
    else{
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ha ocurrido un error. Intente nuevamente'),
        backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      ));
    }
  }
}

class _CoverOpinionInfo extends StatelessWidget {
  const _CoverOpinionInfo({ Key? key, required this.articlePurchase }) : super(key: key);

  final ArticleToPurchase articlePurchase;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            articlePurchase.title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 18
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            CurrencyUtil.formatToCurrencyString(articlePurchase.unitPrice, symbol: '\$') + ' x ${articlePurchase.quantity} unidades',
            style: GoogleFonts.montserrat()
          )
        ],
      ),
    );
  }
}
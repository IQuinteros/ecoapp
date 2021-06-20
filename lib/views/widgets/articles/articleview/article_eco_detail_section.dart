import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoDetailSection extends StatelessWidget {
  const EcoDetailSection({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnContent = [];
    
    if(article.form.hasDetail){
      if(article.form.getIndicator().hasRecycledMaterials){
        columnContent.add(_EcoTitle(title: 'Este producto contiene materiales reciclados y/o reutilizados'));
        columnContent.add(SizedBox(height: 10.0));
        columnContent.add(Text(article.form.recycledMatsDetail, style: GoogleFonts.montserrat()));
        columnContent.add(SizedBox(height: 20.0));
      }
      if(article.form.getIndicator().hasReuseTips){
        columnContent.add(_EcoTitle(title: '¡Reutiliza! Estos son los tips del vendedor'));
        columnContent.add(SizedBox(height: 10.0));
        columnContent.add(Text(article.form.reuseTips, style: GoogleFonts.montserrat()));
        columnContent.add(SizedBox(height: 20.0));
      }
      if(article.form.getIndicator().isRecyclableProduct){
        columnContent.add(_EcoTitle(title: 'Este producto es reciclable'));
        columnContent.add(SizedBox(height: 10.0));
        columnContent.add(Text(article.form.recycledProdDetail, style: GoogleFonts.montserrat()));
        columnContent.add(SizedBox(height: 20.0));
      }
      columnContent.removeLast();
    }
    else{
      columnContent = [
        _EcoTitle(title: 'Producto amigable al entorno'),
        Text(
          article.form.generalDetail
        )
      ];
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnContent,
      )
    );
  }
}

class _EcoTitle extends StatelessWidget {
  const _EcoTitle({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.eco,
            color: EcoAppColors.MAIN_DARK_COLOR
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}
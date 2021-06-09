import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoItemsList<T extends BaseModel> extends StatelessWidget {
  const EcoItemsList({
    Key? key,
    required this.elements, 
    required this.forEachElementWidget
  }) : super(key: key);

  final List<T> elements;
  final Widget Function(T) forEachElementWidget;

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];

    elements.forEach((element) { 
      content.addAll([forEachElementWidget(element), Divider(thickness: 1,)]);
    });

    if(elements.isEmpty){
      return Container(
        margin: EdgeInsets.only(
          top: 30.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'No hay artículos para mostrar',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontStyle: FontStyle.italic
              ),
            ),
          ]
        ),
      );
    }

    return Column(
      children: content
    );
  }
}
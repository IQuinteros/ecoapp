import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/widgets/normal_input.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        // TODO: Create combobox inputs
        children: [
          Text(
            'Filtrar por:',
            style: GoogleFonts.montserrat(
              fontSize: 18.0
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.0),
          Divider(thickness: 1,),
          SizedBox(height: 10.0),
          NormalInput(
            header: 'Categoría', 
            hint: 'Busca por categoría', 
            icon: Icons.category_rounded
          ),
          SizedBox(height: 10.0),
          NormalInput(
            header: 'Valoración', 
            hint: 'Busca por valoración', 
            icon: Icons.star_rounded
          ),
          SizedBox(height: 10.0),
          NormalInput(
            header: 'Precio', 
            hint: 'Busca por precios', 
            icon: Icons.payments_rounded
          )
        ],
      ),
    );
  }
}
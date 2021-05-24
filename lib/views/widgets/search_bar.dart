import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/widgets/search/search_delegate.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final textField = TextField(
      style: GoogleFonts.montserrat(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Busca en Marketplace',
        suffixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0
        )
      ),
      readOnly: true,
      onTap: (){
        showSearch(
          context: context, 
          delegate: ArticleSearch()
        );
      },
    );

    final filterButton = IconButton(
      icon: Icon(Icons.filter_list_outlined), 
      onPressed: (){}
    );

    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0
      ),
      child: Row(
        children: [
          Expanded(child: textField),
          filterButton
        ],
      )
    );
  }
}
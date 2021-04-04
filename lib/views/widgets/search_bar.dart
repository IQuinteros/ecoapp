import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final textField = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Buscar en Marketplace',
        suffixIcon: Icon(Icons.search)
      ),
    );

    final filterButton = IconButton(
      icon: Icon(Icons.filter_list_outlined), 
      onPressed: (){}
    );

    return Container(
      margin: EdgeInsets.only(
        top: 30.0,
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
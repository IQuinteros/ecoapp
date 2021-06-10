import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/views/result_view.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleSearch extends SearchDelegate {

  ArticleSearch({
    String hintText = 'Buscar artículos',
  }) : super(
    searchFieldLabel: hintText,
    searchFieldStyle: GoogleFonts.montserrat(),
    textInputAction: TextInputAction.search
  );

  String selection = '';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    // Appbar left icon
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ), 
      onPressed: (){
        close(context, null);
      }
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    /* return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.redAccent,
        child: Text(selection),
      ),
    ); */
    close(context, query);   
    print(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  
  /*
  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions when user write
    final suggestedList = query.isEmpty? recentMovies
      : movies.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestedList[i]),
          onTap: (){ 
            selection = suggestedList[i];
            showResults(context);
          },
        );
      }
    );
  }*/

}
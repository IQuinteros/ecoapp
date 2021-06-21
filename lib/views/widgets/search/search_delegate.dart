import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/models/search.dart';
import 'package:flutter_ecoapp/views/result_view.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleSearch extends SearchDelegate {

  ArticleSearch({
    String hintText = 'Buscar artículos',
  }) : super(
    searchFieldLabel: hintText,
    textInputAction: TextInputAction.search,
    searchFieldDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.montserrat()
    )
  );

  String selection = '';

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
    final userBloc = BlocProvider.of<UserBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    if(userBloc.searchModels.length <= 0){
      return FutureBuilder(
        future: userBloc.getSearchOfUser(profileBloc.currentProfile),
        initialData: <SearchModel>[],
        builder: (BuildContext context, AsyncSnapshot<List<SearchModel>> snapshot){
          switch(snapshot.connectionState){            
            case ConnectionState.done:
              return _searchsToList(snapshot.data!, context);
            default: return LinearProgressIndicator();
          }
      });
    } else{
      return _searchsToList(userBloc.searchModels, context);
    }    
    
  }

  Widget _searchsToList(List<SearchModel> searchs, BuildContext context){
    searchs = searchs.where((element) => element.searchText.contains(query)).toList();
    List<SearchModel> finalSearch = [];
    searchs.forEach((element) { 
      bool contains = false;
      finalSearch.forEach((inFinal) {
        if(inFinal.searchText.toLowerCase() == element.searchText.toLowerCase()) contains = true;
      });

      if(!contains) finalSearch.add(element);
    });

    List<Widget> tiles = finalSearch.map((e) => ListTile(
      leading: Icon(
        Icons.history
      ),
      title: Text(
        e.searchText,
        style: GoogleFonts.montserrat(),
      ),
      onTap: () => close(context, e.searchText),
    )).toList();

    return ListView(
      children: tiles
    );
  }

}
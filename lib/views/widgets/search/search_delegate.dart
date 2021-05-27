import 'package:flutter/material.dart';

class ArticleSearch extends SearchDelegate {

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
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.redAccent,
        child: Text(selection),
      ),
    );
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
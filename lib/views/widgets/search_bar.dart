import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/views/result_view.dart';
import 'package:flutter_ecoapp/views/widgets/search/search_delegate.dart';
import 'package:flutter_ecoapp/views/widgets/search/search_filter.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {

  final String? searching;

  const SearchBar({Key? key, this.searching}) : super(key: key);

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
        ),
      ),
      controller: TextEditingController(text: searching),
      readOnly: true,
      onTap: () async {
        var result = await showSearch(
          context: context, 
          delegate: ArticleSearch(),
          query: searching
        );
        if(result == null) return;
        uploadSearch(context, result);
        AppBloc appBloc = BlocProvider.of<AppBloc>(context);
        Navigator.popUntil(context, ModalRoute.withName('/'));
        var value = await Navigator.push(context, MaterialPageRoute(builder: (__) => ResultView(searching: result,)));
        if(value != null) appBloc.mainEcoNavBar.onTap(value);
      },
    );

    final filterButton = IconButton(
      icon: Icon(Icons.filter_list_outlined), 
      onPressed: () async {
        await SearchFilter.openSearchFilter(context: context);
      }
    );
    
    return Container(
      margin: EdgeInsets.only(
        top: 15.0,
        //left: 10.0,
        //right: 10.0,
        bottom: 15.0
      ),
      child: Row(
        children: [
          Expanded(child: textField),
          filterButton
        ],
      )
    );
  }

  void uploadSearch(BuildContext context, String? result){
    if(result != null && result.isNotEmpty){
      // Upload search to database
      final userBloc = BlocProvider.of<UserBloc>(context);
      final profileBloc = BlocProvider.of<ProfileBloc>(context);
      userBloc.uploadNewSearch(profileBloc.currentProfile, result);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/text_style.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){
    final content = Column(
      children: [
        SearchBar(),
        EcoTitle(
          text: 'Mi Historial',
        ),
        EcoAppDebug.getArticleItems()
      ],
    );

    return SingleChildScrollView(
      child: content,
      scrollDirection: Axis.vertical,
    );
  }
}
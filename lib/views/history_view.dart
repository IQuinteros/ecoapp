import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context){
    return SingleChildScrollView(
      child: Column(children: [],),
      scrollDirection: Axis.vertical,
    );
  }
}
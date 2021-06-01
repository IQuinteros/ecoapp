import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/base.dart';

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

    return Column(
      children: content
    );
  }
}
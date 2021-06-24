import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';

class IndexAppBar extends StatelessWidget {
  const IndexAppBar({
    Key? key, this.searching, this.onCloseFilter
  }) : super(key: key);

  final String? searching;
  final Function()? onCloseFilter;

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Theme.of(context).canvasColor,
      foregroundColor: Colors.white,
      floating: true,
      pinned: false,
      title: SearchBar(searching: searching, onCloseFilter: onCloseFilter,),
      stretch: false,
      forceElevated: true,
      snap: true,
      leading: Container(),
      leadingWidth: 0,
    );
  }
}
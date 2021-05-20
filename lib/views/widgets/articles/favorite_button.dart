import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class FavoriteButton extends StatefulWidget {

  final bool favorite;

  const FavoriteButton({Key key, this.favorite = true}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(this.favorite);
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  _FavoriteButtonState(this.isFavorite);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite? Icons.favorite : Icons.favorite_outline), 
      color: isFavorite? EcoAppColors.RED_COLOR : Colors.black54,
      onPressed: toggleFavorite
    );
  }

  void toggleFavorite() => setState(() => isFavorite = !isFavorite);
}
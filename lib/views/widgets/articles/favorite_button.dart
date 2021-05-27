import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class FavoriteButton extends StatefulWidget {

  final bool favorite;
  final Color enabledColor;
  final Color disabledColor;

  const FavoriteButton({
    Key key, 
    this.favorite = true, 
    this.disabledColor = Colors.black54,
    this.enabledColor = EcoAppColors.RED_COLOR
  }) : super(key: key);

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
      color: isFavorite? widget.enabledColor : widget.disabledColor,
      onPressed: toggleFavorite
    );
  }

  void toggleFavorite() => setState(() => isFavorite = !isFavorite);
}
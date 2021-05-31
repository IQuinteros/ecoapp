import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class StarsRow extends StatelessWidget {
  final double rating;

  const StarsRow({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    
    //int ratingCeil = rating.ceil();

    for(int i = 0; i < 5; i++){
      stars.add(getStar(filled: rating - i));
    }

    return Row(
      children: stars
    );
  }

  Widget getStar({double filled = 0}){
    return Icon(
      filled <= 0
        ? Icons.star_outline_rounded 
        : filled >= 1
          ? Icons.star_rounded
          : Icons.star_half_rounded,
      color: EcoAppColors.ACCENT_COLOR,
    );
  }
}
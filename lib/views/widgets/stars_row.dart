import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class StarsRow extends StatefulWidget {
  final double rating;
  final bool editable;

  final Function(double)? onEdit;

  const StarsRow({Key? key, required this.rating, this.editable = false, this.onEdit}) : super(key: key);

  @override
  _StarsRowState createState() => _StarsRowState();
}

class _StarsRowState extends State<StarsRow> {

  double? newRating;
  
  @override
  Widget build(BuildContext context) {
    if(newRating == null) newRating = widget.rating;

    List<Widget> stars = [];
    
    //int ratingCeil = rating.ceil();
    for(int i = 0; i < 5; i++){
      stars.add(getStar(filled: newRating! - i, index: i));
    }

    return Row(
      children: stars
    );
  }

  Widget getStar({double filled = 0, int index = 0}){
    return Container(
      child: widget.editable? IconButton(
        icon: Icon(
            filled <= 0
              ? Icons.star_outline_rounded 
              : filled >= 1
                ? Icons.star_rounded
                : Icons.star_half_rounded,
            color: EcoAppColors.ACCENT_COLOR,
        ),
        iconSize: widget.editable? 40 : 25,
        onPressed: widget.editable? () {
          setState(() {
            newRating = index + 1.toDouble();
            widget.onEdit?.call(newRating!);
          });
        } : () {},
      ) : Icon(
        filled <= 0
            ? Icons.star_outline_rounded 
            : filled >= 1
              ? Icons.star_rounded
              : Icons.star_half_rounded,
          color: EcoAppColors.ACCENT_COLOR,
          size: 25
      ),
    );
  }
}
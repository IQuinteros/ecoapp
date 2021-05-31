import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCoverSection extends StatelessWidget {
  const ProfileCoverSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final img = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: Image(
        image: NetworkImage('https://picsum.photos/500/300'),
        fit: BoxFit.cover,
      ),
      width: 80,
      height: 80,
    );

    final content = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Iniciar sesión',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            'Inicia sesión fácilmente y disfruta de una experiencia completa',
            style: GoogleFonts.montserrat(),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0
        ),
        child: Row(
          children: [
            img,
            SizedBox(width: 20.0,),
            Expanded(child: content)
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'login');
      },
    );
  }
}

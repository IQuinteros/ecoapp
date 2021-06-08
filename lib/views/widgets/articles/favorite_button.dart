import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';

class FavoriteButton extends StatefulWidget {

  final bool favorite;
  final Color enabledColor;
  final Color disabledColor;

  const FavoriteButton({
    Key? key, 
    this.favorite = true, 
    this.disabledColor = Colors.black54,
    this.enabledColor = EcoAppColors.RED_COLOR
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(this.favorite);
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  bool isScaling = false;
  bool isShake = false;

  _FavoriteButtonState(this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context); 
    
    ProfileModel? profile = profileBloc.currentProfile;
    if(profile == null) isFavorite = false;

    return ShakeAnimatedWidget(
      duration: Duration(seconds: 1),
      enabled: isShake,
      shakeAngle: Rotation.deg(z: 30),
      curve: Curves.ease,
      child: ScaleAnimatedWidget.tween(
        enabled: this.isScaling,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
        scaleDisabled: 1,
        scaleEnabled: 1.5,
        child: IconButton(
          icon: Icon(isFavorite? Icons.favorite : Icons.favorite_outline), 
          color: isFavorite? widget.enabledColor : widget.disabledColor,
          onPressed: () => profile != null? toggleFavorite() : displayProfileMessage(context)
        ),
      ),
    );
  }

  void initShake(){
    if(isShake) return;
    setState(() {
      isShake = true;
    });
    Timer(Duration(seconds: 1), () {
      setState(() {
        isShake = false;
      });
    });
  }

  void initScale(){
    if(isScaling) return;
    if(isFavorite) return;
    setState(() {
      isScaling = true;
    });
    Timer(Duration(milliseconds: 200), () {
      setState(() {
        isScaling = false;
      });
    });
  }

  void toggleFavorite() {
    initScale();
    setState(() => isFavorite = !isFavorite);
  }

  void displayProfileMessage(BuildContext context){
    initShake();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Debe iniciar sesión para marcar el artículo como favorito'),
      backgroundColor: EcoAppColors.MAIN_DARK_COLOR,
      action: SnackBarAction(
        label: "Iniciar sesión",
        textColor: EcoAppColors.ACCENT_COLOR,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (__) => LoginView())),
      ),
    ));
  }
}
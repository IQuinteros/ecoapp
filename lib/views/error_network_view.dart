import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/providers/base_api.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorNetworkView extends StatelessWidget {
  const ErrorNetworkView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FailConnectReason reason = ModalRoute.of(context)!.settings.arguments as FailConnectReason;

    String message = 'Ha ocurrido un problema con la conexión';
    switch(reason){
      case FailConnectReason.refused: message = 'Ha ocurrido un problema con la conexión';
        break;
      case FailConnectReason.status: message = 'No se ha logrado establecer la conexión';
        break;
      case FailConnectReason.decoding: message = 'Ha ocurrido un problema con nuestro servidor';
        break;
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: (){
                    Navigator.popAndPushNamed(context, '/');
                    //Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  }, 
                  child: Text(
                    'Reintentar conectar',
                    style: GoogleFonts.montserrat(
                      color: EcoAppColors.MAIN_COLOR
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorNetworkModal extends StatelessWidget {
  const ErrorNetworkModal({ Key? key, required this.reason }) : super(key: key);

  final FailConnectReason reason;

  @override
  Widget build(BuildContext context) {
    String message = 'Ha ocurrido un problema con la conexión';
    switch(reason){
      case FailConnectReason.refused: message = 'Ha ocurrido un problema con la conexión';
        break;
      case FailConnectReason.status: message = 'No se ha logrado establecer la conexión';
        break;
      case FailConnectReason.decoding: message = 'Ha ocurrido un problema con nuestro servidor';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10.0),
            Text(
              message,
              style: GoogleFonts.montserrat(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: (){
                //Navigator.popUntil(context, '/');
                //Navigator.popAndPushNamed(context, '/');
                Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
              }, 
              child: Text(
                'Reintentar conectar',
                style: GoogleFonts.montserrat(
                  color: EcoAppColors.MAIN_COLOR
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
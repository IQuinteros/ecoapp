import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/article_bloc.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/models/store.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/style/colors.dart';
import 'package:flutter_ecoapp/views/widgets/articles/future_articles.dart';
import 'package:flutter_ecoapp/views/widgets/search_bar.dart';
import 'package:flutter_ecoapp/views/widgets/store/storeview/store_cover_section.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatelessWidget {

  final List<PhotoModel> photos;
  final String title;
  final int initialIndex;

  const ImageView({Key? key, required this.photos, this.initialIndex = 0, this.title = 'Imágenes'}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    PageController pageController = PageController(
      initialPage: initialIndex
    );

    return Scaffold(
      backgroundColor: EcoAppColors.BLACK_COLOR,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded),
          color: Colors.white,
          iconSize: 40,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: PhotoViewGallery(
            pageOptions: photos.map<PhotoViewGalleryPageOptions>((e) => PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(e.photoUrl),
                minScale: PhotoViewComputedScale.contained * 0.9,
                maxScale: PhotoViewComputedScale.covered * 1.1,
              )).toList(),
            loadingBuilder: (context, progress) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              ),
            ),
            pageController: pageController,
            backgroundDecoration: BoxDecoration(
              color: EcoAppColors.BLACK_COLOR
            ),
          ),
        ),
      ),
    );
  }

}


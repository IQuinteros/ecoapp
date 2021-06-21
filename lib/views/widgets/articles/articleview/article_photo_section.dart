import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';
import 'package:flutter_ecoapp/views/image_view.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    if(article.photos.length <= 1)
      return Container();

    return Container(
      height: 100,
      margin: EdgeInsets.only(
        bottom: 20.0
      ),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 20.0
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: getPhotoItems().sublist(1, getPhotoItems().length),
          ),
        ),
      ),
    );
  }

  List<Widget> getPhotoItems() => article.photos.map<Widget>((element) => _PhotoItem(photoUrl: element.photoUrl, index: article.photos.indexOf(element), article: article,)).toList();
}

class _PhotoItem extends StatelessWidget {
  const _PhotoItem({
    Key? key,
    required this.photoUrl,
    required this.index,
    required this.article
  }) : super(key: key);

  final String photoUrl;
  final ArticleModel article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(
          right: 10.0
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 1
            )
          ],
          borderRadius: BorderRadius.circular(5)
        ),
        child: Image(
          image: NetworkImage(photoUrl),
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (__) => ImageView(photos: article.photos, initialIndex: index, title: article.title,))),
    );
  }
}
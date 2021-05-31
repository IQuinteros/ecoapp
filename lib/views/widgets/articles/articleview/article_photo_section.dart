import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/models/article.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    if(article.photos == null || article.photos.length <= 0)
      return Container();

    return Container(
      height: 100,
      margin: EdgeInsets.only(
        bottom: 10.0
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 20.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getPhotoItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> getPhotoItems() => article.photos.map<Widget>((element) => _PhotoItem(photoUrl: element.photoUrl)).toList();
}

class _PhotoItem extends StatelessWidget {
  const _PhotoItem({
    Key? key,
    required this.photoUrl,
  }) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
          ]
        ),
        child: Image(
          image: NetworkImage(photoUrl),
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      onTap: (){},
    );
  }
}
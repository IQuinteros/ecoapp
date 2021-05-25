import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/article_view.dart';
import 'package:flutter_ecoapp/views/main_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecomercio',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: MainView(),
        routes: {
          'article': (BuildContext context) => ArticleView()
        },
    );
  }
}

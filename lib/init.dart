import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/categories_view.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/main_view.dart';
import 'package:flutter_ecoapp/views/register_view.dart';
import 'package:flutter_ecoapp/views/store_view.dart';

void initMain(){
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
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => MainView(),
          'store': (BuildContext context) => StoreView(),
          'login': (BuildContext context) => LoginView(),
          'register': (BuildContext context) => RegisterView(),
          'categories': (BuildContext context) => CategoriesView()
        },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/models/profile.dart';
import 'package:flutter_ecoapp/providers/sqlite/profile_local_api.dart';
import 'package:flutter_ecoapp/splash.dart';
import 'package:flutter_ecoapp/views/categories_view.dart';
import 'package:flutter_ecoapp/views/debug/debug.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/main_view.dart';
import 'package:flutter_ecoapp/views/register_view.dart';
import 'package:flutter_ecoapp/views/store_view.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  useSqlite();
  runApp(MyApp());
}

void useSqlite() async {
  final localProfile = ProfileLocalAPI();
  await localProfile.initialize();
  localProfile.insert(ProfileModel(
    id: 1, 
    name: 'Ignacio', 
    lastName: 'Quinteros',
    email: 'i.quinteros@hotmail.com', 
    contactNumber: 123456, 
    bithday: DateTime.now(), 
    termsChecked: true, 
    location: 'Mi casa', 
    createdDate: DateTime.now(),
    lastUpdateDate: DateTime.now(),
    rut: 12345, 
    rutDv: '2'
  ));

  List<ProfileModel> profiles = await localProfile.select();
  print(profiles);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final content = BlocProvider(
      create: (BuildContext context) => ProfileBloc(),
      child: MaterialApp(
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
      ),
    );

    return content;
  }
}

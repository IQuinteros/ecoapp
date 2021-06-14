import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecoapp/bloc/app_bloc.dart';
import 'package:flutter_ecoapp/bloc/cart_bloc.dart';
import 'package:flutter_ecoapp/bloc/district_bloc.dart';
import 'package:flutter_ecoapp/bloc/profile_bloc.dart';
import 'package:flutter_ecoapp/bloc/user_bloc.dart';
import 'package:flutter_ecoapp/views/categories_view.dart';
import 'package:flutter_ecoapp/views/login_view.dart';
import 'package:flutter_ecoapp/views/main_view.dart';
import 'package:flutter_ecoapp/views/register_view.dart';
import 'package:flutter_ecoapp/views/store_view.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final content = MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (__) => ProfileBloc(),
        ),
        BlocProvider<DistrictBloc>(
          create: (BuildContext context) => DistrictBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<AppBloc>(
          create: (BuildContext context) => AppBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
      ],
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

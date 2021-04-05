import 'package:flutter/material.dart';
import 'package:flutter_ecoapp/views/history_view.dart';
import 'package:flutter_ecoapp/views/home_view.dart';

class EcoAppRoutes{
  static Map<String, Widget Function(BuildContext)> getRoutes() => {
    '/': (BuildContext context) => HomeView(),
    '/history': (BuildContext context) => HistoryView(),
  };

  static String _currentRoute = '/';
  static String getCurrentRoute() => _currentRoute;
  static void setCurrentRoute(String newRoute) => _currentRoute = newRoute;
}
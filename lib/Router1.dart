
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/pagesAndViewModels/welcome/WelcomePage.dart';


class Router1 {



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(settings:RouteSettings(name: "/"), builder: (_) => WelcomePage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/screens/login_screen/login_screen.dart';
import 'package:untitled/ui/screens/register_screen/register_screen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case LoginScreen.routeName : return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RegisterScreen.routeName : return MaterialPageRoute(builder: (context)=> const RegisterScreen());
      case HomeScreen.routeName : return MaterialPageRoute(builder: (context)=> const HomeScreen());
      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(title: const Text('Error Screen'),),
        body: const Center(
          child: Text('Error Screen'),
        ),
      );
    });
  }
}
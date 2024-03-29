import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/screens/add_post/add_post.dart';
import 'package:untitled/ui/screens/chat_details/chat_details.dart';
import 'package:untitled/ui/screens/edit_screen/edit_screen.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/screens/login_screen/login_screen.dart';
import 'package:untitled/ui/screens/register_screen/register_screen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/' : return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RegisterScreen.routeName : return MaterialPageRoute(builder: (context)=> const RegisterScreen());
      case HomeScreen.routeName : return MaterialPageRoute(builder: (context)=> const HomeScreen(),maintainState: false);
      case AddPostScreen.routeName : return MaterialPageRoute(builder: (context)=> const AddPostScreen());
      case EditScreen.routeName : return MaterialPageRoute(builder: (context)=> const EditScreen());
      case ChatDetailsScreen.routeName : return MaterialPageRoute(builder: (context)=> ChatDetailsScreen(userModel: args,));
      default: return MaterialPageRoute(builder: (context)=> const ErrorScreen());
    }
  }
}


class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);
static const routeName ='/error';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Screen'),),
      body: const Center(
        child: Text('Error Screen'),
      ),
    );
  }
}

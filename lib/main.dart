import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc_observer.dart';
import 'package:untitled/config/theme/theme.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/data/local/cache_helper.dart';
import 'package:untitled/core/data/local/constant_uid.dart';
import 'package:untitled/core/routes/routes.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/screens/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  //shared preference
  await CacheHelper.init();
  userId = CacheHelper.getData(key: 'uId') ?? '';

  //check if  there is saved uId == (token)
  //to show home screen or login page
  String? initRoute;
  if (userId!.isEmpty) {
    initRoute = LoginScreen.routeName;
  } else {
    initRoute = HomeScreen.routeName;
  }
  runApp(MyApp(
    initRoute: initRoute,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.initRoute,
  }) : super(key: key);
  final String? initRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //user management cubit (login and register)
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()..getUserData(),
        ),
        // after login or register cubit
        // BlocProvider<AppCubit>(
        //   create: (BuildContext context) => AppCubit(),
        // ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, index) {},
        builder: (context, index) {
          return MaterialApp(
            title: 'Social app',
            theme: lightTheme,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: initRoute,
          );
        },
      ),
    );
  }
}

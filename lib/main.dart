import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc_observer.dart';
import 'package:untitled/core/blocs/app_bloc/app_cubit.dart';
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
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId')?? '';
  String? initRoute;
  if(uId!.isNotEmpty){
    initRoute = HomeScreen.routeName;
  }else{initRoute = LoginScreen.routeName;}
  runApp(MyApp(initRoute: initRoute,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initRoute,}) : super(key: key);
  final String? initRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, index) {},
        builder: (context, index) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
              ),
            ),
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: initRoute,
          );
        },
      ),
    );
  }
}

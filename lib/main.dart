import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc_observer.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/ui/screens/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
      MultiBlocProvider(providers: [
        BlocProvider<AuthCubit>(
        create: (BuildContext context) => AuthCubit(),
      ),],
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, index){},
            builder: (context, index){
              return
                  MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: const LoginScreen(),
                  // const MyHomePage(title: 'Flutter Demo Home Page')
                )
                ;
            },
          ),)

    ;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
          child: Text('You have pushed the button this many times')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

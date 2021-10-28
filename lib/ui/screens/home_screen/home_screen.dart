import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/app_bloc/app_cubit.dart';
import 'package:untitled/core/blocs/app_bloc/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              AppBar(leading: const SizedBox(), title: const Text('News feed')),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                //check if the email is verified
                //if it's not verified show the alert message
                if(!FirebaseAuth.instance.currentUser!.emailVerified)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 40.0,
                  width: double.infinity - 20,
                  color: Colors.amber[400],
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Expanded(
                          child: Text('Your email is not verified',
                              style: TextStyle(color: Colors.black))),
                      TextButton(
                        onPressed: () {
                          //send email verification
                          FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        },
                        child: const Text('verify now'),
                      ),
                    ],
                  ),

                ),
                // const SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/routes/constant_route_functions.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/screens/register_screen/register_screen.dart';
import 'package:untitled/ui/widgets/default_form_button.dart';
import 'package:untitled/ui/widgets/default_text_form_field.dart';
import 'package:untitled/ui/widgets/snack_bar.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // if (state is SuccessCreateUser) {
        //   CacheHelper.saveData(key: 'uId', value: state.userModel.uId)
        //       .then((value) {
        //     userId = state.userModel.uId!;
        //     navigateAndRemove(
        //         context: context, namedRoute: HomeScreen.routeName);
        //   }).catchError((e) {});
        // }

        if (state is LoginSuccessState) {
          SnackBars.buildSnackBar(context: context, text: 'welcome' + state.userName.toString(), backgroundColor: Colors.green);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Log In'),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DefaultTextFormField(
                      obscureText: false,
                      onFieldSubmitted: (String? value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.person,
                      hintText: 'user email',
                    ),
                    const SizedBox(height: 10.0),
                    DefaultTextFormField(
                      obscureText: cubit.obscureText,
                      onFieldSubmitted: (String? value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.mail,
                      suffixIcon: Icons.password,
                      hintText: 'password',
                      suffixOnPressed: () => cubit.obscurePassword(),
                    ),
                    const SizedBox(height: 20.0),
                    DefaultFormButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                              namedRoute: HomeScreen.routeName);
                        }
                      },
                      text: 'log in',
                    ),
                    const SizedBox(height: 10.0),
                    const Text('Or'),
                    const SizedBox(height: 10.0),
                    DefaultFormButton(
                      onPressed: () {
                        navigate(
                          context: context,
                          namedRoute: RegisterScreen.routeName,
                        );
                      },
                      text: 'register',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/data/local/cache_helper.dart';
import 'package:untitled/core/data/local/constant_uid.dart';
import 'package:untitled/core/routes/constant_route_functions.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/widgets/default_form_button.dart';
import 'package:untitled/ui/widgets/default_text_form_field.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
// final TextEditingController confirmPasswordController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SuccessCreateUser) {
          CacheHelper.saveData(key: 'uId', value: state.userModel.uId)
              .then((value) {
            uId = state.userModel.uId!;
            navigateAndRemove(
                context: context, namedRoute: HomeScreen.routeName);
          }).catchError((e) {});
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Register'),
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
                          return '*your name is required please enter your name';
                        }
                      },
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person,
                      hintText: 'user name',
                    ),
                    const SizedBox(height: 10.0),
                    DefaultTextFormField(
                      obscureText: false,
                      onFieldSubmitted: (String? value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '*your phone number is required please enter your phone number';
                        }
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone,
                      hintText: 'number',
                    ),
                    const SizedBox(height: 10.0),
                    DefaultTextFormField(
                      obscureText: false,
                      onFieldSubmitted: (String? value) {},
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '*email is required please enter your email address';
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      hintText: 'user email',
                    ),
                    const SizedBox(height: 10.0),
                    DefaultTextFormField(
                      obscureText: cubit.obscureText,
                      onFieldSubmitted: (String? value) {
                        if (value!.isEmpty) {
                          return '*password is required please enter your password address';
                        }
                        // else if (passwordController !=
                        //     confirmPasswordController) {
                        //   return '*your passwords are not identical';
                        // }
                      },
                      validator: (String? value) {},
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.password,
                      suffixIcon: Icons.password,
                      hintText: 'password',
                      suffixOnPressed: () => cubit.obscurePassword(),
                    ),
                    const SizedBox(height: 10.0),
                    // DefaultTextFormField(
                    //   obscureText: cubit.obscureText,
                    //   onFieldSubmitted: (String? value) {},
                    //   validator: (String? value) {
                    //     if (passwordController != confirmPasswordController) {
                    //       return '*your passwords are not identical';
                    //     }
                    //   },
                    //   controller: confirmPasswordController,
                    //   keyboardType: TextInputType.text,
                    //   prefixIcon: Icons.password,
                    //   suffixIcon: Icons.password,
                    //   hintText: 'confirm your password',
                    //   suffixOnPressed: () => cubit.obscurePassword(),
                    // ),
                    const SizedBox(height: 10.0),
                    DefaultFormButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          return cubit.userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
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

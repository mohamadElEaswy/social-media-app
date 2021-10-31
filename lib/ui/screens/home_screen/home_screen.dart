import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/config/theme/icon_broken.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/data/end_points.dart';
import 'package:untitled/core/routes/constant_route_functions.dart';
import 'package:untitled/ui/screens/add_post/add_post.dart';
import 'package:untitled/ui/screens/home_screen/build_post_item.dart';
import 'package:untitled/ui/widgets/snack_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is GetUserSuccessState) {
          SnackBars.buildSnackBar(
              context: context, text: 'welcome ' + state.model.name, backgroundColor: Colors.green);
        }
        if (state is SocialNewPostState) {
          navigate(context: context, namedRoute: AddPostScreen.routeName);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNav(index);
            },
          ),
          appBar: AppBar(
              leading:  Container(),
              actions: [
                IconButton(
                  icon: const Icon(
                    IconBroken.Notification,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    IconBroken.Search,
                  ),
                  onPressed: () {},
                ),
              ],
              title: Text(cubit.titles[cubit.currentIndex])),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //check if the email is verified
          //if it's not verified show the alert message
          if (!FirebaseAuth.instance.currentUser!.emailVerified)
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
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    },
                    child: const Text('verify now'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10.0),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.fitWidth,
                  height: 180,
                  width: double.infinity,
                ),
              ),
              Text(
                'communicate with friends',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.black54, backgroundColor: Colors.white60),
              ),
            ],
          ),
          const BuildPostItem(),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/config/theme/icon_broken.dart';
import 'package:untitled/core/blocs/app_bloc/app_state.dart';
import 'package:untitled/core/data/local/constant_uid.dart';
import 'package:untitled/ui/screens/add_post/add_post.dart';
import 'package:untitled/ui/screens/chat_screen/chat_screen.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/screens/setting_screen/setting_screen.dart';
import 'package:untitled/ui/screens/users_screen/users_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      print(value.data().toString());
      emit(GetUserSuccessState());
    }).catchError((e) {
      emit(GetUserErrorState(error: e.toString()));
    });
  }

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Chat,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Paper_Upload,
      ),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Location,
      ),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = const [
    HomeContent(),
    ChatScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  List<String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index == 2) {
      emit(SocialNewPostState());
    } else
    {
      currentIndex = index;
      emit(ChangeBottomNav());
    }
  }
}

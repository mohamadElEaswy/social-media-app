import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/data/local/cache_helper.dart';
import 'package:untitled/core/data/local/constant_uid.dart';
import 'package:untitled/core/models/user_model.dart';
import 'package:untitled/core/routes/constant_route_functions.dart';
// management to login and register
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitState());
  static AuthCubit get(context) => BlocProvider.of(context);

  //change password visibility
  // Login & register
  bool obscureText = true;
  void obscurePassword() {
    obscureText = !obscureText;
    emit(ChangePasswordVisibility());
  }

  //register method in fire base
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context, required String namedRoute
  }) {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        email: email,
        phone: phone,
        name: name,
      );
      navigateAndRemove(
          context: context, namedRoute: namedRoute);
      emit(SuccessRegisterState());
    }).catchError((e) {
      emit(ErrorRegisterState(error: e.toString()));
    });
  }
 // register new user data in the fire cloud
  void userCreate(
      {required String name,
      required String phone,
      required String email,
      required String uId}) {
    emit(LoadingCreateUser());
    UserModel model =
        UserModel(name: name, email: email, phone: phone, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) async {
      userId = await CacheHelper.saveData(key: 'uId', value: uId);

      emit(SuccessCreateUser(userModel: model));
    }).catchError((e) {
      emit(ErrorCreateUser(error: e.toString()));
    });
  }
// login method
  void userLogin({required String email, required String password, required BuildContext context, required String namedRoute }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      userId = value.user!.uid;
          navigateAndRemove(
          context: context, namedRoute: namedRoute);
      emit(LoginSuccessState(userName: value.user!.displayName));
    }).catchError((e) {
      // print(e.toString());
      emit(LoginErrorState(error: e.toString()));
    });
  }
}

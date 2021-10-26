import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/models/user_model.dart';

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

  //register method
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
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
      emit(SuccessRegisterState());
    }).catchError((e) {
      emit(ErrorRegisterState(error: e.toString()));
    });
  }

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
        .then((value) {
      emit(SuccessCreateUser(userModel: model));
    }).catchError((e) {
      print(e.toString());
      emit(ErrorCreateUser(error: e.toString()));
    });
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(LoginErrorState(error: e.toString()));
    });
  }
}

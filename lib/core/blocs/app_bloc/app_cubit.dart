import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/app_bloc/app_state.dart';
import 'package:untitled/core/data/local/constant_uid.dart';

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
    })
        .catchError((e) {
      emit(GetUserErrorState(error: e.toString()));
          print(e);
    });
  }
}

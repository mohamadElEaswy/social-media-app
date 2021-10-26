import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/app_bloc/app_state.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);


  void getUseData(){
    FirebaseFirestore.instance.collection('users').doc();
  }
}
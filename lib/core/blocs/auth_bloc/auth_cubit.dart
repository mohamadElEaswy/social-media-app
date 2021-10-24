import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit() : super(LoginInitState());
  static AuthCubit get(context) => BlocProvider.of(context);


}
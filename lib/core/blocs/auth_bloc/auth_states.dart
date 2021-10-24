abstract class AuthState{}

class LoginInitState extends AuthState{}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{}
class LoginErrorState extends AuthState{}

class ChangePasswordVisibility extends AuthState{}
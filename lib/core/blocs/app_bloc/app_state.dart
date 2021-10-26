abstract class AppState{}

class AppInitState extends AppState{}
class GetUserSuccessState extends AppState{}
class GetUserErrorState extends AppState{
  final String error;

  GetUserErrorState({required this.error});
}
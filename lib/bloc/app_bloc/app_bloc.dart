import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {




bool hasToken = false;
bool hisFirstTime = true;
    on<SigendUp>((event, emit) {
       emit(HeSigendUp());
      print("He was signed up");
      hasToken = true;
      hisFirstTime = true;
    config.get<SharedPreferences>().setBool('status', hasToken);
    config.get<SharedPreferences>().setBool('second status', hisFirstTime);
    });

  on<LoggedOut>((event, emit) {
       emit(HeLoggedOut());
      print("He was logged out");
      hasToken = false;
      hisFirstTime = false;
  config.get<SharedPreferences>().setBool('status', hasToken);
    config.get<SharedPreferences>().setBool('second status', hisFirstTime);
    });

      on<LoggedIn>((event, emit) {
       emit(HeLoggedIn());
      print("He was logged in");
      hasToken = true;
      hisFirstTime = false;
  config.get<SharedPreferences>().setBool('status', hasToken);
    config.get<SharedPreferences>().setBool('second status', hisFirstTime);
    });

    var token = config.get<SharedPreferences>().getBool('status');
var firstTime = config.get<SharedPreferences>().getBool('second status');
on<CheckAppStatus>((event, emit) {
if(token == true && firstTime == true){
  emit(HeSigendUp());
}else if(token ==false && firstTime == false ){
  emit(HeLoggedOut());
}else if(token ==true && firstTime == false ){
  emit(HeLoggedIn());
}
});
  }
}




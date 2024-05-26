import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osscam/core/config/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    bool hisFirstTime = false;
    bool hasToken = false; // in begining
// we have to test the value of the sharde of it have a vlue inside it so the token is exist >> hasToken = True,
    if (config.get<SharedPreferences>().getString(
              'token',
            ) !=
        null) {
      hasToken = true;
    } else {
      hasToken = false;
    }
// we will save this in sharard maybe , an if he create or join a project its value will return to true,
    var firstTime = config.get<SharedPreferences>().getBool('status');
    if (firstTime != null) {
      hisFirstTime = firstTime;
    }
    on<CheckAppStatus>(
      (event, emit) {
        if (hasToken == true && hisFirstTime == true) {
          emit(HeJoinApp());
        } else if (hasToken == true && hisFirstTime == false) {
          emit(UseingApp());
        } else if (hasToken == false && hisFirstTime == false) {
          emit(HeLoggedOut());
        } else if (hasToken == false && hisFirstTime == true) {
          emit(HisFirstTime());
        }
      },
    );

    // on<SigendUp>((event, emit) {
    //   emit(HisFirstTime());
    //   print("He was signed up");
    //   hasToken = true;
    //   hisFirstTime = true;
    //   config.get<SharedPreferences>().setBool('status', hasToken);
    //   config.get<SharedPreferences>().setBool('second status', hisFirstTime);
    // });

    // on<LoggedOut>((event, emit) {
    //   emit(HeLoggedOut());
    //   print("He was logged out");
    //   hasToken = false;
    //   hisFirstTime = false;
    //   config.get<SharedPreferences>().setBool('status', hasToken);
    //   config.get<SharedPreferences>().setBool('second status', hisFirstTime);
    // });

    // on<LoggedIn>((event, emit) {
    //   emit(HeLoggedIn());
    //   print("He was logged in");
    //   hasToken = true;
    //   hisFirstTime = false;
    //   config.get<SharedPreferences>().setBool('status', hasToken);
    //   config.get<SharedPreferences>().setBool('second status', hisFirstTime);
    // });

    // var token = config.get<SharedPreferences>().getBool('status');
    // var firstTime = config.get<SharedPreferences>().getBool('second status');
    // on<CheckAppStatus>((event, emit) {
    //   if (token == true && firstTime == true) {
    //     emit(HisFirstTime());
    //   } else if (token == false && firstTime == false) {
    //     emit(HeLoggedOut());
    //   } else if (token == true && firstTime == false) {
    //     emit(HeLoggedIn());
    //   }
    // });
  }
}

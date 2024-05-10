import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt config = GetIt.instance;
// Future<void> saveUserToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString('user_token', token);
//   config.registerSingletonAsync<SharedPreferences>(() async {
//   return await SharedPreferences.getInstance();
// });

// Usage in your widget
// final prefs = config<SharedPreferences>();
// }

init() async {
  config.registerSingleton(await SharedPreferences.getInstance());
}

// Future<void> clearUserToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.remove('user_token');
// }

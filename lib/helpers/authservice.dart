import 'package:finalproject/helpers/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  
  Future<bool> login() async {
    bool _logged = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(loginState) != null) {
      _logged = preferences.getBool(loginState);
    } else {
      _logged = false;
    }
    return _logged;
  }
}

import 'package:flutter_github/services/auth_service/auth_service.dart';
import 'package:flutter_github/utils/constants.dart';
import 'package:flutter_github/utils/pref_init.dart';
import 'package:flutter_github/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  var loading = false.obs;

  getAuthService() async {
    loading(true);
    final res = await AuthService.signInWithGitHub();

    if (res != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString(Constants.token, res.credential!.accessToken!);

      loading(false);
      PrefUtil.setValue(Constants.name, res.user!.displayName!);
      Get.offAll(HomeScreen());
    } else {
      loading(false);
    }
  }
}

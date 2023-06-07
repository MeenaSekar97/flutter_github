import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/utils/constants.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/pref_init.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_github/view/auth_screen/auth_screen.dart';
import 'package:flutter_github/view/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefUtil.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    preferences: preferences,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.preferences});
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 771),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
              primaryColor: primaryColor,
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white),
          home: child,
        );
      },
      child: preferences.containsKey(Constants.token)
          ? const HomeScreen()
          : const AuthScreen(title: 'First Method'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_github/controller/auth_controller/auth_controller.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_github/view/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.title});

  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 58.h),
              child: Center(
                child: Image.asset(
                  'assets/github.png',
                  height: 83.h,
                  width: 203.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 09.hp),
              child: Center(
                child: Image.asset(
                  'assets/computer.png',
                  height: 220.h,
                  width: 240.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 41.h),
              child: Center(
                  child: Text(
                'Lets built from here ...',
                style: bold,
              )),
            ),
            Padding(
              padding: EdgeInsets.all(1.5.hp),
              child: Center(
                  child: Text(
                'Our platform drives innovation with tools that boost developer velocity',
                style: medium,
                textAlign: TextAlign.center,
              )),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(3.hp),
              child: ElevatedButton(
                onPressed: () {
                  authController.getAuthService();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: authController.loading.value
                    ? Transform.scale(
                        scale: 0.5, child: const CircularProgressIndicator())
                    : Text(
                        'Sign in with Github',
                        style:
                            bold.copyWith(color: Colors.white, fontSize: 14.sp),
                      ),
              ),
            )
          ],
        ),
      );
    });
  }
}

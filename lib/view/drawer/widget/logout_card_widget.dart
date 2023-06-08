import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/styles.dart';
import '../../auth_screen/auth_screen.dart';

class LogoutCardWidget extends StatelessWidget {
  const LogoutCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        FirebaseAuth.instance.signOut();
        Get.offAll(const AuthScreen(title: 'title'));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3), spreadRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.logout_outlined),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Logout',
                  style: bold.copyWith(fontSize: 16.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

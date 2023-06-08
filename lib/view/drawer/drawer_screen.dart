import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/controller/organisation_controller/organisation_controller.dart';
import 'package:flutter_github/view/auth_screen/auth_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/org_model.dart';
import '../../utils/styles.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen(
      {super.key, required this.onSelect, required this.globalKey});

  final Function(OrgModel orgName) onSelect;
  final GlobalKey<ScaffoldState> globalKey;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  var orgController = Get.find<OrgController>();

  @override
  void initState() {
    super.initState();
  }

  var data = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 16.h),
                height: 90.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://avatars.githubusercontent.com/u/75603354?v=4",
                        height: 50.h,
                        width: 50.w,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data!.displayName!,
                          style: bold.copyWith(fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff22CCCC)),
                          child: Text(
                            data!.email!,
                            style: bold.copyWith(
                                fontSize: 12.sp, color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ...orgController.orgList.map((element) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () {
                      widget.onSelect(element);
                      widget.globalKey.currentState!.closeDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (orgController.current.value == element.login)
                              ? const Color(0xffD3DEFF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              element.avatarUrl,
                              height: 40.h,
                              fit: BoxFit.fill,
                              width: 40.h,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              element.login,
                              style: bold.copyWith(fontSize: 16.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              GestureDetector(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
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
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1)
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
              )
            ],
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_github/view/drawer/drawer_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller/home_controller.dart';
import '../../controller/organisation_controller/organisation_controller.dart';
import '../widget/app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  var orgController = Get.put(OrgController(), permanent: true);
  var homeController = Get.put(HomeController(), permanent: true);
  var avatar = '';
  var title = '';
  var sub = '';

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        key: key,
        backgroundColor: Colors.white,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: DrawerScreen(
            globalKey: key,
            onSelect: (orgName) {
              avatar = orgName.avatarUrl;
              title = orgName.login;
              sub = orgName.nodeId.toString();
              homeController.getAuthService(orgName.login);
              setState(() {});
            },
          ),
        ),
        appBar: appBarWidget(avatar, title, sub,
            context: context, height: AppBar().preferredSize.height, key: key),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Projects',
                  style: bold.copyWith(fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (homeController.orgList.isNotEmpty)
                  ...homeController.orgList
                      .map((element) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.h, vertical: 10.h),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 0.5)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      element.owner.avatarUrl,
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        element.name,
                                        style: bold.copyWith(fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        element.owner.login,
                                        style: medium.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  const Icon(Icons.arrow_forward_ios_outlined)
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                if (homeController.orgList.isEmpty) ...[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.hp),
                      child: Center(
                          child: (title == '')
                              ? Text(
                                  'Please selected the organsation.',
                                  style: medium,
                                )
                              : Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator())))
                ]
              ],
            ),
          ),
        ),
      );
    });
  }
}

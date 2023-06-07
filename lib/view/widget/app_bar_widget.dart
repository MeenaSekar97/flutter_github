import 'package:flutter/material.dart';
import 'package:flutter_github/utils/constants.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/pref_init.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget appBarWidget(String avatar, title, sub,
    {required BuildContext context,
    required double height,
    required GlobalKey<ScaffoldState> key}) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 25.hp),
    child: Stack(
      children: <Widget>[
        Container(
          // Background
          color: Theme.of(context).primaryColor,
          height: 21.5.hp,
          width: MediaQuery.of(context).size.width,
          // Background
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        key.currentState!.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  Center(
                    child: Text("Github",
                        style: bold.copyWith(
                            color: Colors.white, fontSize: 17.sp)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Hi ${PrefUtil.getValue(Constants.name, 'defaultValue')} ',
                  style: bold.copyWith(color: Colors.white, fontSize: 17.sp),
                ),
              ),
              SizedBox(
                height: 1.hp,
              ),
            ],
          ),
        ),

        Container(), // Required some widget in between to float AppBar

        Positioned(
            // To take AppBar Size only
            top: 16.hp,
            left: 20.0,
            right: 20.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
              height: 90.h,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1)
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: (title == '')
                  ? Center(
                      child: Text(
                      'Please selected the organsation.',
                      style: medium,
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            avatar,
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
                            Flexible(
                              child: Text(
                                title,
                                style: bold.copyWith(fontSize: 18.sp),
                              ),
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
                                sub,
                                style: bold.copyWith(
                                    fontSize: 12.sp, color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
            ))
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_github/view/branch_screen/branch_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/project_model.dart';
import '../../../utils/styles.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({super.key, required this.element});

  final ProjectModel element;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(BranchScreen(
          model: element,
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 0.5)
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}

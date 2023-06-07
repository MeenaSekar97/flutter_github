import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/project_model.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key, required this.model});

  final ProjectModel model;

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          'Project',
          style: medium.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(15.hp),
            child: Container(
              height: 15.hp,
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.model.owner.avatarUrl,
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
                              widget.model.name,
                              style: bold.copyWith(
                                  fontSize: 16.sp, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              widget.model.owner.login,
                              style: medium.copyWith(
                                  fontSize: 14.sp, color: Color(0xffE1E2FF)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 5.h),
                    child: Text(
                      'Last update : ${widget.model.updatedAt}',
                      style: medium.copyWith(color: Color(0xffE1E2FF)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/branch_commit_list.dart';
import '../../../utils/styles.dart';

class CommitDetailsCard extends StatelessWidget {
  const CommitDetailsCard({super.key, required this.commitListModel});

  final BranchCommitListModel commitListModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 0.5)
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color(0xffFFF5EB),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(
              Icons.folder,
              color: Color(0xffFDBD00),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commitListModel.commit.message,
                style: bold.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                dateFromString(commitListModel.commit.committer.date),
                style: medium.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/verify.png',
                    height: 14.h,
                    width: 11.w,
                  ),
                  SizedBox(
                    width: 7.h,
                  ),
                  Text(
                    commitListModel.commit.committer.name,
                    style: medium.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_github/controller/branch_controller/branch_controller.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/branch_commit_list.dart';
import '../../model/project_model.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key, required this.model});

  final ProjectModel model;

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  var branchController = Get.put(BranchController());

  @override
  void initState() {
    branchController.getAuthService(
        widget.model.owner.login, widget.model.name);
    super.initState();
  }

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
                                  fontSize: 14.sp,
                                  color: const Color(0xffE1E2FF)),
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
                      style: medium.copyWith(color: const Color(0xffE1E2FF)),
                    ),
                  )
                ],
              ),
            )),
      ),
      body: Obx(() {
        if (branchController.loading.isTrue) {
          return Center(
            child: Transform.scale(
                scale: 0.5, child: const CircularProgressIndicator()),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                  child: Row(
                children: branchController.branchList
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                e.name,
                                style: medium.copyWith(color: Colors.white),
                              )),
                        ))
                    .toList(),
              )),
              ...branchController.branchCommitList
                  .map(
                    (element) => CommitDetailsCard(
                      commitListModel: element,
                    ),
                  )
                  .toList()
            ],
          ),
        );
      }),
    );
  }
}

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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              commitListModel.committer.avatarUrl,
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
                commitListModel.commit.message,
                style: bold.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                commitListModel.commit.committer.date.toIso8601String(),
                style: medium.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const Icon(Icons.person_remove),
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

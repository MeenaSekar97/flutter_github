import 'package:flutter/material.dart';
import 'package:flutter_github/controller/branch_controller/branch_controller.dart';
import 'package:flutter_github/utils/extensions.dart';
import 'package:flutter_github/utils/styles.dart';
import 'package:flutter_github/view/branch_screen/widgets/commited_list_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
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
                      'Last update : ${dateFromString(widget.model.updatedAt)}',
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
                          child: GestureDetector(
                            onTap: () {
                              branchController.currentBranch(e.commit.sha);
                              branchController.getCommitListService(
                                  widget.model.owner.login,
                                  widget.model.name,
                                  e.commit.sha);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color:
                                        branchController.currentBranch.value ==
                                                (e.commit.sha)
                                            ? Colors.black
                                            : const Color(0xffF3F4FF),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  e.name,
                                  style: medium.copyWith(
                                      color: branchController
                                                  .currentBranch.value ==
                                              (e.commit.sha)
                                          ? Colors.white
                                          : const Color(0xff5F607E)),
                                )),
                          ),
                        ))
                    .toList(),
              )),
              if (branchController.commitLoading.isTrue)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.hp),
                  child: Transform.scale(
                      scale: 0.5, child: const CircularProgressIndicator()),
                ),
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

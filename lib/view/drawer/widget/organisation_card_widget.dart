import 'package:flutter/material.dart';
import 'package:flutter_github/model/org_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/organisation_controller/organisation_controller.dart';
import '../../../utils/styles.dart';

class OrganisationCardWidget extends StatelessWidget {
  const OrganisationCardWidget(
      {super.key, required this.orgController, required this.element});

  final OrgController orgController;
  final OrgModel element;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

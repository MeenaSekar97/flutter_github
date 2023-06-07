import 'package:flutter_github/model/branch_list_model.dart';
import 'package:flutter_github/model/project_model.dart';
import 'package:flutter_github/services/branch_service/branch_service.dart';
import 'package:flutter_github/services/home_service/home_service.dart';
import 'package:get/get.dart';

import '../../model/branch_commit_list.dart';

class BranchController extends GetxController {
  var loading = false.obs;
  var branchList = <BranchListModel>[].obs;

  var branchCommitList = <BranchCommitListModel>[].obs;

  getAuthService(name, projectname) async {
    loading(true);
    final res = await BranchService.branchListService(name, projectname);

    print('data$res');

    if (res != null) {
      branchList(res);
      if (res.isNotEmpty) {
        getCommitListService(name, projectname, res[0].commit.sha);
      }
      loading(false);
    } else {
      loading(false);
    }
  }

  getCommitListService(name, projectname, sha) async {
    loading(true);
    final res =
        await BranchService.branchCommitListService(name, projectname, sha);

    print('data$res');

    if (res != null) {
      branchCommitList(res);
      loading(false);
    } else {
      loading(false);
    }
  }
}

import 'package:flutter_github/model/branch_list_model.dart';
import 'package:flutter_github/model/project_model.dart';
import 'package:flutter_github/services/branch_service/branch_service.dart';
import 'package:flutter_github/services/home_service/home_service.dart';
import 'package:get/get.dart';

import '../../model/branch_commit_list.dart';

class BranchController extends GetxController {
  var loading = false.obs;
  var commitLoading = false.obs;
  var branchList = <BranchListModel>[].obs;

  var currentBranch = ''.obs;

  var branchCommitList = <BranchCommitListModel>[].obs;

  getAuthService(name, projectname) async {
    loading(true);
    final res = await BranchService.branchListService(name, projectname);

    if (res != null) {
      branchList(res);
      if (res.isNotEmpty) {
        currentBranch(res[0].commit.sha);
        getCommitListService(name, projectname, res[0].commit.sha);
      }
      loading(false);
    } else {
      loading(false);
    }
  }

  getCommitListService(name, projectname, sha) async {
    commitLoading(true);
    branchCommitList.clear();
    final res =
        await BranchService.branchCommitListService(name, projectname, sha);

    if (res != null) {
      commitLoading(false);
      branchCommitList(res);
    } else {
      commitLoading(false);
    }
  }
}

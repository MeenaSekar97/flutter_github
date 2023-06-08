import 'package:flutter_github/model/org_model.dart';
import 'package:flutter_github/model/project_model.dart';
import 'package:flutter_github/services/home_service/home_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var orgList = <ProjectModel>[].obs;
  var avatar = ''.obs;
  var title = ''.obs;
  var sub = ''.obs;

  getAuthService(name, OrgModel org) async {
    loading(true);
    orgList.clear();
    avatar.value = org.avatarUrl;
    title.value = org.login;
    sub.value = org.nodeId.toString();
    final res = await HomeService.homeService(name);

    if (res != null) {
      if (res.isNotEmpty) {
        orgList(res);
        loading(false);
      } else {
        loading(false);
      }
    } else {
      loading(false);
    }
  }
}

import 'package:flutter_github/controller/home_controller/home_controller.dart';
import 'package:flutter_github/model/org_model.dart';
import 'package:flutter_github/services/organisation_service/organisation_service.dart';
import 'package:get/get.dart';

class OrgController extends GetxController {
  @override
  void onInit() {
    getOrganisationService();
    super.onInit();
  }

  var initial = true.obs;

  var loading = false.obs;
  var current = ''.obs;
  var orgList = <OrgModel>[].obs;

  getOrganisationService() async {
    loading(true);
    final res = await OrganisationService.organisationService();

    if (res != null) {
      orgList(res);
      loading(false);
      if (Get.isRegistered<HomeController>() && orgList.isNotEmpty) {
        current(orgList[0].login);
        var data = Get.find<HomeController>();
        data.getProjectService(orgList[0].login, orgList[0]);
        data.title(orgList[0].login);
        data.avatar(orgList[0].avatarUrl);
        data.sub(orgList[0].nodeId.toString());
      }
    } else {
      loading(false);
    }
  }
}

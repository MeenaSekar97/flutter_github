import 'package:flutter_github/model/org_model.dart';
import 'package:flutter_github/services/organisation_service/organisation_service.dart';
import 'package:get/get.dart';

class OrgController extends GetxController {
  @override
  void onInit() {
    getAuthService();
    super.onInit();
  }

  var initial = true.obs;

  var loading = false.obs;
  var orgList = <OrgModel>[].obs;

  getAuthService() async {
    loading(true);
    final res = await OrganisationService.organisationService();

    if (res != null) {
      orgList(res);
      loading(false);
    } else {
      loading(false);
    }
  }
}

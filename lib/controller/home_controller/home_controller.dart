import 'package:flutter_github/model/project_model.dart';
import 'package:flutter_github/services/home_service/home_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var orgList = <ProjectModel>[].obs;

  getAuthService(name) async {
    loading(true);
    final res = await HomeService.homeService(name);

    print('data${res}');

    if (res != null) {
      orgList(res);
      loading(false);
    } else {
      loading(false);
    }
  }
}

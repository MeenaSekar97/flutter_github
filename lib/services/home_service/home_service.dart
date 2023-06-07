import 'package:flutter_github/model/project_model.dart';
import 'package:flutter_github/utils/constants.dart';
import 'package:flutter_github/utils/pref_init.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class HomeService {
  static Client client = http.Client();
  static Future<List<ProjectModel>?> homeService(name) async {
    var headers = {
      'Authorization':
          'Bearer ${PrefUtil.getValue(Constants.token, 'defaultValue')}'
    };
    // Create a new provider
    try {
      var res = await http.get(
          Uri.parse('https://api.github.com/orgs/$name/repos'),
          headers: headers);

      if (res.statusCode == 200) {
        return projectModelFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      print('res$e');
      return null;
    }
  }
}

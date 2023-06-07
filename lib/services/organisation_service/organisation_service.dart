import 'package:flutter_github/utils/constants.dart';
import 'package:flutter_github/utils/pref_init.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../model/org_model.dart';

class OrganisationService {
  static Client client = http.Client();
  static Future<List<OrgModel>?> organisationService() async {
    var headers = {
      'Authorization':
          'Bearer ${PrefUtil.getValue(Constants.token, 'defaultValue')}'
    };
    // Create a new provider
    try {
      var res = await http.get(Uri.parse('https://api.github.com/user/orgs'),
          headers: headers);

      if (res.statusCode == 200) {
        return orgModelFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      print('res$e');
      return null;
    }
  }
}

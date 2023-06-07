import 'package:flutter_github/model/branch_commit_list.dart';
import 'package:flutter_github/model/branch_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../utils/constants.dart';
import '../../utils/pref_init.dart';

class BranchService {
  static Client client = http.Client();
  static Future<List<BranchListModel>?> branchListService(
      repoName, projectName) async {
    var headers = {
      'Authorization':
          'Bearer ${PrefUtil.getValue(Constants.token, 'defaultValue')}'
    };
    // Create a new provider
    try {
      var res = await http.get(
          Uri.parse(
              'https://api.github.com/repos/$repoName/$projectName/branches'),
          headers: headers);

      if (res.statusCode == 200) {
        return branchListModelFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      print('res$e');
      return null;
    }
  }

  static Future<List<BranchCommitListModel>?> branchCommitListService(
      repoName, projectName, sha) async {
    var headers = {
      'Authorization':
          'Bearer ${PrefUtil.getValue(Constants.token, 'defaultValue')}'
    };
    // Create a new provider
    try {
      var res = await http.get(
          Uri.parse(
              'https://api.github.com/repos/$repoName/$projectName/commits?per_page=20&sha=$sha'),
          headers: headers);

      if (res.statusCode == 200) {
        return branchCommitListModelFromJson(res.body);
      } else {
        return null;
      }
    } catch (e) {
      print('res$e');
      return null;
    }
  }
}

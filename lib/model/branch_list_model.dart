// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'dart:convert';

List<BranchListModel> branchListModelFromJson(String str) => List<BranchListModel>.from(json.decode(str).map((x) => BranchListModel.fromJson(x)));

String branchListModelToJson(List<BranchListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchListModel {
    String name;
    Commit commit;
    bool protected;

    BranchListModel({
        required this.name,
        required this.commit,
        required this.protected,
    });

    factory BranchListModel.fromJson(Map<String, dynamic> json) => BranchListModel(
        name: json["name"],
        commit: Commit.fromJson(json["commit"]),
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "commit": commit.toJson(),
        "protected": protected,
    };
}

class Commit {
    String sha;
    String url;

    Commit({
        required this.sha,
        required this.url,
    });

    factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        sha: json["sha"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
    };
}

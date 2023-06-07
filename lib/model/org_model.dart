// To parse this JSON data, do
//
//     final orgModel = orgModelFromJson(jsonString);

import 'dart:convert';

List<OrgModel> orgModelFromJson(String str) => List<OrgModel>.from(json.decode(str).map((x) => OrgModel.fromJson(x)));

String orgModelToJson(List<OrgModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrgModel {
    String login;
    int id;
    String nodeId;
    String url;
    String reposUrl;
    String eventsUrl;
    String hooksUrl;
    String issuesUrl;
    String membersUrl;
    String publicMembersUrl;
    String avatarUrl;
    dynamic description;

    OrgModel({
        required this.login,
        required this.id,
        required this.nodeId,
        required this.url,
        required this.reposUrl,
        required this.eventsUrl,
        required this.hooksUrl,
        required this.issuesUrl,
        required this.membersUrl,
        required this.publicMembersUrl,
        required this.avatarUrl,
        this.description,
    });

    factory OrgModel.fromJson(Map<String, dynamic> json) => OrgModel(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        url: json["url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        hooksUrl: json["hooks_url"],
        issuesUrl: json["issues_url"],
        membersUrl: json["members_url"],
        publicMembersUrl: json["public_members_url"],
        avatarUrl: json["avatar_url"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "url": url,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "hooks_url": hooksUrl,
        "issues_url": issuesUrl,
        "members_url": membersUrl,
        "public_members_url": publicMembersUrl,
        "avatar_url": avatarUrl,
        "description": description,
    };
}

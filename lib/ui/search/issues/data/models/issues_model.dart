import 'dart:convert';

import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';

class IssuesModel extends Issues {
  const IssuesModel({
    required int totalCount,
    required bool incompleteResults,
    required List<ItemsModel> items,
  }) : super(
          totalCount: totalCount,
          incompleteResults: incompleteResults,
          items: items,
        );

  factory IssuesModel.fromJson(Map<String, dynamic> json) {
    List<ItemsModel> items = [];
    if (json['items'] != null) {
      items = <ItemsModel>[];
      json['items'].forEach((v) {
        items.add(ItemsModel.fromJson(v));
      });
    }
    return IssuesModel(
      totalCount: json['total_count'],
      incompleteResults: json['incomplete_results'],
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    data['items'] = items.map((v) => jsonEncode(jsonEncode(v))).toList();
    return data;
  }
}

class ItemsModel extends Items {
  const ItemsModel({
    required String? url,
    required String? repositoryUrl,
    required String? labelsUrl,
    required String? commentsUrl,
    required String? eventsUrl,
    required String? htmlUrl,
    required int id,
    required String? nodeId,
    required int number,
    required String? title,
    required User? user,
    required List<Labels> labels,
    required String? state,
    required bool locked,
    required User? assignee,
    required List<User?> assignees,
    required int comments,
    required String? createdAt,
    required String? updatedAt,
    required String? closedAt,
    required String? authorAssociation,
    required dynamic activeLockReason,
    required String? body,
    required String? timelineUrl,
    required dynamic performedViaGithubApp,
    required num score,
  }) : super(
          url: url,
          repositoryUrl: repositoryUrl,
          labelsUrl: labelsUrl,
          commentsUrl: commentsUrl,
          eventsUrl: eventsUrl,
          htmlUrl: htmlUrl,
          id: id,
          nodeId: nodeId,
          number: number,
          title: title,
          user: user,
          labels: labels,
          state: state,
          locked: locked,
          assignee: assignee,
          assignees: assignees,
          comments: comments,
          createdAt: createdAt,
          updatedAt: updatedAt,
          closedAt: closedAt,
          authorAssociation: authorAssociation,
          activeLockReason: activeLockReason,
          body: body,
          timelineUrl: timelineUrl,
          performedViaGithubApp: performedViaGithubApp,
          score: score,
        );

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    List<LabelsModel> labels = [];
    if (json['labels'] != null) {
      labels = <LabelsModel>[];
      json['labels'].forEach((v) {
        labels.add(LabelsModel.fromJson(v));
      });
    }

    List<UserModel> assignees = [];
    if (json['assignees'] != null) {
      assignees = <UserModel>[];
      json['assignees'].forEach((v) {
        assignees.add(UserModel.fromJson(v));
      });
    }

    return ItemsModel(
      url: json['url'],
      repositoryUrl: json['repository_url'],
      labelsUrl: json['labels_url'],
      commentsUrl: json['comments_url'],
      eventsUrl: json['events_url'],
      htmlUrl: json['html_url'],
      id: json['id'],
      nodeId: json['node_id'],
      number: json['number'],
      title: json['title'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      labels: labels,
      state: json['state'],
      locked: json['locked'],
      assignee: json['assignee'] != null
          ? UserModel.fromJson(json['assignee'])
          : null,
      assignees: assignees,
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      closedAt: json['closed_at'],
      authorAssociation: json['author_association'],
      activeLockReason: json['active_lock_reason'],
      body: json['body'],
      timelineUrl: json['timeline_url'],
      performedViaGithubApp: json['performed_via_github_app'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['repository_url'] = repositoryUrl;
    data['labels_url'] = labelsUrl;
    data['comments_url'] = commentsUrl;
    data['events_url'] = eventsUrl;
    data['html_url'] = htmlUrl;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['number'] = number;
    data['title'] = title;
    if (user != null) {
      data['user'] = jsonEncode(user);
    }
    if (labels != null) {
      data['labels'] = labels?.map((v) => jsonEncode(v)).toList();
    }
    data['state'] = state;
    data['locked'] = locked;
    if (assignee != null) {
      data['assignee'] = jsonEncode(assignee);
    }
    if (assignees != null) {
      data['assignees'] = assignees?.map((v) => jsonEncode(v)).toList();
    }
    data['comments'] = comments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['closed_at'] = closedAt;
    data['author_association'] = authorAssociation;
    data['active_lock_reason'] = activeLockReason;
    data['body'] = body;
    data['timeline_url'] = timelineUrl;
    data['performed_via_github_app'] = performedViaGithubApp;
    data['score'] = score;
    return data;
  }
}

class UserModel extends User {
  const UserModel({
    required String? login,
    required int id,
    required String? nodeId,
    required String? avatarUrl,
    required String? gravatarId,
    required String? url,
    required String? htmlUrl,
    required String? followersUrl,
    required String? followingUrl,
    required String? gistsUrl,
    required String? starredUrl,
    required String? subscriptionsUrl,
    required String? organizationsUrl,
    required String? reposUrl,
    required String? eventsUrl,
    required String? receivedEventsUrl,
    required String? type,
    required bool siteAdmin,
  }) : super(
          login: login,
          id: id,
          nodeId: nodeId,
          avatarUrl: avatarUrl,
          gravatarId: gravatarId,
          url: url,
          htmlUrl: htmlUrl,
          followersUrl: followersUrl,
          followingUrl: followingUrl,
          gistsUrl: gistsUrl,
          starredUrl: starredUrl,
          subscriptionsUrl: subscriptionsUrl,
          organizationsUrl: organizationsUrl,
          reposUrl: reposUrl,
          eventsUrl: eventsUrl,
          receivedEventsUrl: receivedEventsUrl,
          type: type,
          siteAdmin: siteAdmin,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      gravatarId: json['gravatar_id'],
      url: json['url'],
      htmlUrl: json['html_url'],
      followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      gistsUrl: json['gists_url'],
      starredUrl: json['starred_url'],
      subscriptionsUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],
      receivedEventsUrl: json['received_events_url'],
      type: json['type'],
      siteAdmin: json['site_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['followers_url'] = followersUrl;
    data['following_url'] = followingUrl;
    data['gists_url'] = gistsUrl;
    data['starred_url'] = starredUrl;
    data['subscriptions_url'] = subscriptionsUrl;
    data['organizations_url'] = organizationsUrl;
    data['repos_url'] = reposUrl;
    data['events_url'] = eventsUrl;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    data['site_admin'] = siteAdmin;
    return data;
  }
}

class LabelsModel extends Labels {
  const LabelsModel({
    required int id,
    required String? nodeId,
    required String? url,
    required String? name,
    required String? color,
    required bool defaults,
    required String? description,
  }) : super(
          id: id,
          nodeId: nodeId,
          url: url,
          name: name,
          color: color,
          defaults: defaults,
          description: description,
        );

  factory LabelsModel.fromJson(Map<String, dynamic> json) {
    return LabelsModel(
      id: json['id'],
      nodeId: json['node_id'],
      url: json['url'],
      name: json['name'],
      color: json['color'],
      defaults: json['default'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['url'] = url;
    data['name'] = name;
    data['color'] = color;
    data['default'] = defaults;
    data['description'] = description;
    return data;
  }
}

import 'package:equatable/equatable.dart';

class Issues extends Equatable {
  final int totalCount;
  final bool incompleteResults;
  final List<Items> items;

  const Issues({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  @override
  List<Object> get props => [
        totalCount,
        incompleteResults,
        items,
      ];
}

class Items extends Equatable {
  final String? url;
  final String? repositoryUrl;
  final String? labelsUrl;
  final String? commentsUrl;
  final String? eventsUrl;
  final String? htmlUrl;
  final int id;
  final String? nodeId;
  final int number;
  final String? title;
  final User? user;
  final List<Labels?>? labels;
  final String? state;
  final bool locked;
  final User? assignee;
  final List<User?>? assignees;
  final int comments;
  final String? createdAt;
  final String? updatedAt;
  final String? closedAt;
  final String? authorAssociation;
  final dynamic activeLockReason;
  final String? body;
  final String? timelineUrl;
  final dynamic performedViaGithubApp;
  final num score;

  const Items({
    this.url,
    this.repositoryUrl,
    this.labelsUrl,
    this.commentsUrl,
    this.eventsUrl,
    this.htmlUrl,
    required this.id,
    this.nodeId,
    required this.number,
    this.title,
    required this.user,
    required this.labels,
    this.state,
    required this.locked,
    required this.assignee,
    required this.assignees,
    required this.comments,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.authorAssociation,
    this.activeLockReason,
    this.body,
    this.timelineUrl,
    this.performedViaGithubApp,
    required this.score,
  });

  @override
  List<Object?> get props => [
        url,
        repositoryUrl,
        labelsUrl,
        commentsUrl,
        eventsUrl,
        htmlUrl,
        id,
        nodeId,
        number,
        title,
        user,
        labels,
        state,
        locked,
        assignee,
        assignees,
        comments,
        createdAt,
        updatedAt,
        closedAt,
        authorAssociation,
        activeLockReason,
        body,
        timelineUrl,
        performedViaGithubApp,
        score,
      ];
}

class User extends Equatable {
  final String? login;
  final int id;
  final String? nodeId;
  final String? avatarUrl;
  final String? gravatarId;
  final String? url;
  final String? htmlUrl;
  final String? followersUrl;
  final String? followingUrl;
  final String? gistsUrl;
  final String? starredUrl;
  final String? subscriptionsUrl;
  final String? organizationsUrl;
  final String? reposUrl;
  final String? eventsUrl;
  final String? receivedEventsUrl;
  final String? type;
  final bool siteAdmin;

  const User({
    this.login,
    required this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    required this.siteAdmin,
  });

  @override
  List<Object?> get props => [
        login,
        id,
        nodeId,
        avatarUrl,
        gravatarId,
        url,
        htmlUrl,
        followersUrl,
        followingUrl,
        gistsUrl,
        starredUrl,
        subscriptionsUrl,
        organizationsUrl,
        reposUrl,
        eventsUrl,
        receivedEventsUrl,
        type,
        siteAdmin,
      ];
}

class Labels extends Equatable {
  final int id;
  final String? nodeId;
  final String? url;
  final String? name;
  final String? color;
  final bool defaults;
  final String? description;

  const Labels({
    required this.id,
    this.nodeId,
    this.url,
    this.name,
    this.color,
    required this.defaults,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        nodeId,
        url,
        name,
        color,
        defaults,
        description,
      ];
}

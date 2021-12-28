import 'dart:convert';

import 'package:sejuta_cita/ui/search/issues/data/models/issues_model.dart';
import 'package:sejuta_cita/ui/search/repo/domain/entities/repository.dart';

class RepositoryModel extends Repository {
  const RepositoryModel({
    required int totalCount,
    required bool incompleteResults,
    required List<RepositoryItemsModel> items,
  }) : super(
          totalCount: totalCount,
          incompleteResults: incompleteResults,
          items: items,
        );

  factory RepositoryModel.fromJson(Map<String?, dynamic> json) {
    List<RepositoryItemsModel> items = [];
    if (json['items'] != null) {
      items = <RepositoryItemsModel>[];
      json['items'].forEach((v) {
        items.add(RepositoryItemsModel.fromJson(v));
      });
    }
    return RepositoryModel(
      totalCount: json['total_count'],
      incompleteResults: json['incomplete_results'],
      items: items,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    data['items'] = items.map((v) => jsonEncode(jsonEncode(v))).toList();
    return data;
  }
}

class RepositoryItemsModel extends RepositoryItems {
  const RepositoryItemsModel({
    required int id,
    required String? nodeId,
    required String? name,
    required String? fullName,
    required bool private,
    required UserModel? owner,
    required String? htmlUrl,
    required String? description,
    required bool fork,
    required String? url,
    required String? forksUrl,
    required String? keysUrl,
    required String? collaboratorsUrl,
    required String? teamsUrl,
    required String? hooksUrl,
    required String? issueEventsUrl,
    required String? eventsUrl,
    required String? assigneesUrl,
    required String? branchesUrl,
    required String? tagsUrl,
    required String? blobsUrl,
    required String? gitTagsUrl,
    required String? gitRefsUrl,
    required String? treesUrl,
    required String? statusesUrl,
    required String? languagesUrl,
    required String? stargazersUrl,
    required String? contributorsUrl,
    required String? subscribersUrl,
    required String? subscriptionUrl,
    required String? commitsUrl,
    required String? gitCommitsUrl,
    required String? commentsUrl,
    required String? issueCommentUrl,
    required String? contentsUrl,
    required String? compareUrl,
    required String? mergesUrl,
    required String? archiveUrl,
    required String? downloadsUrl,
    required String? issuesUrl,
    required String? pullsUrl,
    required String? milestonesUrl,
    required String? notificationsUrl,
    required String? labelsUrl,
    required String? releasesUrl,
    required String? deploymentsUrl,
    required String? createdAt,
    required String? updatedAt,
    required String? pushedAt,
    required String? gitUrl,
    required String? sshUrl,
    required String? cloneUrl,
    required String? svnUrl,
    required String? homepage,
    required int size,
    required int stargazersCount,
    required int watchersCount,
    required String? language,
    required bool hasIssues,
    required bool hasProjects,
    required bool hasDownloads,
    required bool hasWiki,
    required bool hasPages,
    required int forksCount,
    required String? mirrorUrl,
    required bool archived,
    required bool disabled,
    required int openIssuesCount,
    required License? license,
    required bool allowForking,
    required bool isTemplate,
    required List<String?> topics,
    required String? visibility,
    required int forks,
    required int openIssues,
    required int watchers,
    required String? defaultBranch,
    required num score,
  }) : super(
          id: id,
          nodeId: nodeId,
          name: name,
          fullName: fullName,
          private: private,
          owner: owner,
          htmlUrl: htmlUrl,
          description: description,
          fork: fork,
          url: url,
          forksUrl: forksUrl,
          keysUrl: keysUrl,
          collaboratorsUrl: collaboratorsUrl,
          teamsUrl: teamsUrl,
          hooksUrl: hooksUrl,
          issueEventsUrl: issueEventsUrl,
          eventsUrl: eventsUrl,
          assigneesUrl: assigneesUrl,
          branchesUrl: branchesUrl,
          tagsUrl: tagsUrl,
          blobsUrl: blobsUrl,
          gitTagsUrl: gitTagsUrl,
          gitRefsUrl: gitRefsUrl,
          treesUrl: treesUrl,
          statusesUrl: statusesUrl,
          languagesUrl: languagesUrl,
          stargazersUrl: stargazersUrl,
          contributorsUrl: contributorsUrl,
          subscribersUrl: subscribersUrl,
          subscriptionUrl: subscriptionUrl,
          commitsUrl: commitsUrl,
          gitCommitsUrl: gitCommitsUrl,
          commentsUrl: commentsUrl,
          issueCommentUrl: issueCommentUrl,
          contentsUrl: contentsUrl,
          compareUrl: compareUrl,
          mergesUrl: mergesUrl,
          archiveUrl: archiveUrl,
          downloadsUrl: downloadsUrl,
          issuesUrl: issuesUrl,
          pullsUrl: pullsUrl,
          milestonesUrl: milestonesUrl,
          notificationsUrl: notificationsUrl,
          labelsUrl: labelsUrl,
          releasesUrl: releasesUrl,
          deploymentsUrl: deploymentsUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          pushedAt: pushedAt,
          gitUrl: gitUrl,
          sshUrl: sshUrl,
          cloneUrl: cloneUrl,
          svnUrl: svnUrl,
          homepage: homepage,
          size: size,
          stargazersCount: stargazersCount,
          watchersCount: watchersCount,
          language: language,
          hasIssues: hasIssues,
          hasProjects: hasProjects,
          hasDownloads: hasDownloads,
          hasWiki: hasWiki,
          hasPages: hasPages,
          forksCount: forksCount,
          mirrorUrl: mirrorUrl,
          archived: archived,
          disabled: disabled,
          openIssuesCount: openIssuesCount,
          license: license,
          allowForking: allowForking,
          isTemplate: isTemplate,
          topics: topics,
          visibility: visibility,
          forks: forks,
          openIssues: openIssues,
          watchers: watchers,
          defaultBranch: defaultBranch,
          score: score,
        );

  factory RepositoryItemsModel.fromJson(Map<String?, dynamic> json) {
    return RepositoryItemsModel(
      id: json['id'],
      nodeId: json['node_id'],
      name: json['name'],
      fullName: json['full_name'],
      private: json['private'],
      owner: json['owner'] != null ? UserModel.fromJson(json['owner']) : null,
      htmlUrl: json['html_url'],
      description: json['description'],
      fork: json['fork'],
      url: json['url'],
      forksUrl: json['forks_url'],
      keysUrl: json['keys_url'],
      collaboratorsUrl: json['collaborators_url'],
      teamsUrl: json['teams_url'],
      hooksUrl: json['hooks_url'],
      issueEventsUrl: json['issue_events_url'],
      eventsUrl: json['events_url'],
      assigneesUrl: json['assignees_url'],
      branchesUrl: json['branches_url'],
      tagsUrl: json['tags_url'],
      blobsUrl: json['blobs_url'],
      gitTagsUrl: json['git_tags_url'],
      gitRefsUrl: json['git_refs_url'],
      treesUrl: json['trees_url'],
      statusesUrl: json['statuses_url'],
      languagesUrl: json['languages_url'],
      stargazersUrl: json['stargazers_url'],
      contributorsUrl: json['contributors_url'],
      subscribersUrl: json['subscribers_url'],
      subscriptionUrl: json['subscription_url'],
      commitsUrl: json['commits_url'],
      gitCommitsUrl: json['git_commits_url'],
      commentsUrl: json['comments_url'],
      issueCommentUrl: json['issue_comment_url'],
      contentsUrl: json['contents_url'],
      compareUrl: json['compare_url'],
      mergesUrl: json['merges_url'],
      archiveUrl: json['archive_url'],
      downloadsUrl: json['downloads_url'],
      issuesUrl: json['issues_url'],
      pullsUrl: json['pulls_url'],
      milestonesUrl: json['milestones_url'],
      notificationsUrl: json['notifications_url'],
      labelsUrl: json['labels_url'],
      releasesUrl: json['releases_url'],
      deploymentsUrl: json['deployments_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pushedAt: json['pushed_at'],
      gitUrl: json['git_url'],
      sshUrl: json['ssh_url'],
      cloneUrl: json['clone_url'],
      svnUrl: json['svn_url'],
      homepage: json['homepage'],
      size: json['size'],
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      language: json['language'],
      hasIssues: json['has_issues'],
      hasProjects: json['has_projects'],
      hasDownloads: json['has_downloads'],
      hasWiki: json['has_wiki'],
      hasPages: json['has_pages'],
      forksCount: json['forks_count'],
      mirrorUrl: json['mirror_url'],
      archived: json['archived'],
      disabled: json['disabled'],
      openIssuesCount: json['open_issues_count'],
      license: json['license'] != null
          ? LicenseModel.fromJson(json['license'])
          : null,
      allowForking: json['allow_forking'],
      isTemplate: json['is_template'],
      topics: json['topics'].cast<String?>(),
      visibility: json['visibility'],
      forks: json['forks'],
      openIssues: json['open_issues'],
      watchers: json['watchers'],
      defaultBranch: json['default_branch'],
      score: json['score'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['full_name'] = fullName;
    data['private'] = private;
    if (owner != null) {
      data['owner'] = jsonEncode(owner);
    }
    data['html_url'] = htmlUrl;
    data['description'] = description;
    data['fork'] = fork;
    data['url'] = url;
    data['forks_url'] = forksUrl;
    data['keys_url'] = keysUrl;
    data['collaborators_url'] = collaboratorsUrl;
    data['teams_url'] = teamsUrl;
    data['hooks_url'] = hooksUrl;
    data['issue_events_url'] = issueEventsUrl;
    data['events_url'] = eventsUrl;
    data['assignees_url'] = assigneesUrl;
    data['branches_url'] = branchesUrl;
    data['tags_url'] = tagsUrl;
    data['blobs_url'] = blobsUrl;
    data['git_tags_url'] = gitTagsUrl;
    data['git_refs_url'] = gitRefsUrl;
    data['trees_url'] = treesUrl;
    data['statuses_url'] = statusesUrl;
    data['languages_url'] = languagesUrl;
    data['stargazers_url'] = stargazersUrl;
    data['contributors_url'] = contributorsUrl;
    data['subscribers_url'] = subscribersUrl;
    data['subscription_url'] = subscriptionUrl;
    data['commits_url'] = commitsUrl;
    data['git_commits_url'] = gitCommitsUrl;
    data['comments_url'] = commentsUrl;
    data['issue_comment_url'] = issueCommentUrl;
    data['contents_url'] = contentsUrl;
    data['compare_url'] = compareUrl;
    data['merges_url'] = mergesUrl;
    data['archive_url'] = archiveUrl;
    data['downloads_url'] = downloadsUrl;
    data['issues_url'] = issuesUrl;
    data['pulls_url'] = pullsUrl;
    data['milestones_url'] = milestonesUrl;
    data['notifications_url'] = notificationsUrl;
    data['labels_url'] = labelsUrl;
    data['releases_url'] = releasesUrl;
    data['deployments_url'] = deploymentsUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pushed_at'] = pushedAt;
    data['git_url'] = gitUrl;
    data['ssh_url'] = sshUrl;
    data['clone_url'] = cloneUrl;
    data['svn_url'] = svnUrl;
    data['homepage'] = homepage;
    data['size'] = size;
    data['stargazers_count'] = stargazersCount;
    data['watchers_count'] = watchersCount;
    data['language'] = language;
    data['has_issues'] = hasIssues;
    data['has_projects'] = hasProjects;
    data['has_downloads'] = hasDownloads;
    data['has_wiki'] = hasWiki;
    data['has_pages'] = hasPages;
    data['forks_count'] = forksCount;
    data['mirror_url'] = mirrorUrl;
    data['archived'] = archived;
    data['disabled'] = disabled;
    data['open_issues_count'] = openIssuesCount;
    if (license != null) {
      data['license'] = jsonEncode(license);
    }
    data['allow_forking'] = allowForking;
    data['is_template'] = isTemplate;
    data['topics'] = topics;
    data['visibility'] = visibility;
    data['forks'] = forks;
    data['open_issues'] = openIssues;
    data['watchers'] = watchers;
    data['default_branch'] = defaultBranch;
    data['score'] = score;
    return data;
  }
}

class LicenseModel extends License {
  const LicenseModel({
    required String? key,
    required String? name,
    required String? spdxId,
    required String? url,
    required String? nodeId,
  }) : super(key: key, url: url, nodeId: nodeId, name: name, spdxId: spdxId);

  factory LicenseModel.fromJson(Map<String?, dynamic> json) {
    return LicenseModel(
      key: json['key'],
      name: json['name'],
      spdxId: json['spdx_id'],
      url: json['url'],
      nodeId: json['node_id'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['spdx_id'] = spdxId;
    data['url'] = url;
    data['node_id'] = nodeId;
    return data;
  }
}

import 'package:equatable/equatable.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';

class Repository extends Equatable {
  final int totalCount;
  final bool incompleteResults;
  final List<RepositoryItems> items;

  const Repository({
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

class RepositoryItems extends Equatable {
  final int id;
  final String? nodeId;
  final String? name;
  final String? fullName;
  final bool private;
  final User? owner;
  final String? htmlUrl;
  final String? description;
  final bool fork;
  final String? url;
  final String? forksUrl;
  final String? keysUrl;
  final String? collaboratorsUrl;
  final String? teamsUrl;
  final String? hooksUrl;
  final String? issueEventsUrl;
  final String? eventsUrl;
  final String? assigneesUrl;
  final String? branchesUrl;
  final String? tagsUrl;
  final String? blobsUrl;
  final String? gitTagsUrl;
  final String? gitRefsUrl;
  final String? treesUrl;
  final String? statusesUrl;
  final String? languagesUrl;
  final String? stargazersUrl;
  final String? contributorsUrl;
  final String? subscribersUrl;
  final String? subscriptionUrl;
  final String? commitsUrl;
  final String? gitCommitsUrl;
  final String? commentsUrl;
  final String? issueCommentUrl;
  final String? contentsUrl;
  final String? compareUrl;
  final String? mergesUrl;
  final String? archiveUrl;
  final String? downloadsUrl;
  final String? issuesUrl;
  final String? pullsUrl;
  final String? milestonesUrl;
  final String? notificationsUrl;
  final String? labelsUrl;
  final String? releasesUrl;
  final String? deploymentsUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? pushedAt;
  final String? gitUrl;
  final String? sshUrl;
  final String? cloneUrl;
  final String? svnUrl;
  final String? homepage;
  final int size;
  final int stargazersCount;
  final int watchersCount;
  final String? language;
  final bool hasIssues;
  final bool hasProjects;
  final bool hasDownloads;
  final bool hasWiki;
  final bool hasPages;
  final int forksCount;
  final String? mirrorUrl;
  final bool archived;
  final bool disabled;
  final int openIssuesCount;
  final License? license;
  final bool allowForking;
  final bool isTemplate;
  final List<String?> topics;
  final String? visibility;
  final int forks;
  final int openIssues;
  final int watchers;
  final String? defaultBranch;
  final num score;

  const RepositoryItems({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.htmlUrl,
    required this.description,
    required this.fork,
    required this.url,
    required this.forksUrl,
    required this.keysUrl,
    required this.collaboratorsUrl,
    required this.teamsUrl,
    required this.hooksUrl,
    required this.issueEventsUrl,
    required this.eventsUrl,
    required this.assigneesUrl,
    required this.branchesUrl,
    required this.tagsUrl,
    required this.blobsUrl,
    required this.gitTagsUrl,
    required this.gitRefsUrl,
    required this.treesUrl,
    required this.statusesUrl,
    required this.languagesUrl,
    required this.stargazersUrl,
    required this.contributorsUrl,
    required this.subscribersUrl,
    required this.subscriptionUrl,
    required this.commitsUrl,
    required this.gitCommitsUrl,
    required this.commentsUrl,
    required this.issueCommentUrl,
    required this.contentsUrl,
    required this.compareUrl,
    required this.mergesUrl,
    required this.archiveUrl,
    required this.downloadsUrl,
    required this.issuesUrl,
    required this.pullsUrl,
    required this.milestonesUrl,
    required this.notificationsUrl,
    required this.labelsUrl,
    required this.releasesUrl,
    required this.deploymentsUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.gitUrl,
    required this.sshUrl,
    required this.cloneUrl,
    required this.svnUrl,
    required this.homepage,
    required this.size,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.hasIssues,
    required this.hasProjects,
    required this.hasDownloads,
    required this.hasWiki,
    required this.hasPages,
    required this.forksCount,
    required this.mirrorUrl,
    required this.archived,
    required this.disabled,
    required this.openIssuesCount,
    required this.license,
    required this.allowForking,
    required this.isTemplate,
    required this.topics,
    required this.visibility,
    required this.forks,
    required this.openIssues,
    required this.watchers,
    required this.defaultBranch,
    required this.score,
  });

  @override
  List<Object?> get props => [
        id,
        nodeId,
        name,
        fullName,
        private,
        owner,
        htmlUrl,
        description,
        fork,
        url,
        forksUrl,
        keysUrl,
        collaboratorsUrl,
        teamsUrl,
        hooksUrl,
        issueEventsUrl,
        eventsUrl,
        assigneesUrl,
        branchesUrl,
        tagsUrl,
        blobsUrl,
        gitTagsUrl,
        gitRefsUrl,
        treesUrl,
        statusesUrl,
        languagesUrl,
        stargazersUrl,
        contributorsUrl,
        subscribersUrl,
        subscriptionUrl,
        commitsUrl,
        gitCommitsUrl,
        commentsUrl,
        issueCommentUrl,
        contentsUrl,
        compareUrl,
        mergesUrl,
        archiveUrl,
        downloadsUrl,
        issuesUrl,
        pullsUrl,
        milestonesUrl,
        notificationsUrl,
        labelsUrl,
        releasesUrl,
        deploymentsUrl,
        createdAt,
        updatedAt,
        pushedAt,
        gitUrl,
        sshUrl,
        cloneUrl,
        svnUrl,
        homepage,
        size,
        stargazersCount,
        watchersCount,
        language,
        hasIssues,
        hasProjects,
        hasDownloads,
        hasWiki,
        hasPages,
        forksCount,
        mirrorUrl,
        archived,
        disabled,
        openIssuesCount,
        license,
        allowForking,
        isTemplate,
        topics,
        visibility,
        forks,
        openIssues,
        watchers,
        defaultBranch,
        score,
      ];
}

class License extends Equatable {
  final String? key;
  final String? name;
  final String? spdxId;
  final String? url;
  final String? nodeId;

  const License({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  @override
  List<Object?> get props => [
        key,
        name,
        spdxId,
        url,
        nodeId,
      ];
}

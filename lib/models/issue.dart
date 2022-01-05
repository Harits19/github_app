import 'package:github_app/models/user.dart';

class Issue {
  String? url;
  String? repositoryUrl;
  String? labelsUrl;
  String? commentsUrl;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  int? number;
  String? title;
  User? user;
  List<dynamic>? labels;
  String? state;
  bool? locked;
  dynamic assignee;
  List<dynamic>? assignees;
  dynamic milestone;
  int? comments;
  String? createdAt;
  String? updatedAt;
  dynamic closedAt;
  String? authorAssociation;
  dynamic activeLockReason;
  String? body;
  Reactions? reactions;
  String? timelineUrl;
  dynamic performedViaGithubApp;
  double? score;

  Issue({
    this.url,
    this.repositoryUrl,
    this.labelsUrl,
    this.commentsUrl,
    this.eventsUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.number,
    this.title,
    this.user,
    this.labels,
    this.state,
    this.locked,
    this.assignee,
    this.assignees,
    this.milestone,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.authorAssociation,
    this.activeLockReason,
    this.body,
    this.reactions,
    this.timelineUrl,
    this.performedViaGithubApp,
    this.score,
  });

  Issue.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    repositoryUrl = json['repository_url'] as String?;
    labelsUrl = json['labels_url'] as String?;
    commentsUrl = json['comments_url'] as String?;
    eventsUrl = json['events_url'] as String?;
    htmlUrl = json['html_url'] as String?;
    id = json['id'] as int?;
    nodeId = json['node_id'] as String?;
    number = json['number'] as int?;
    title = json['title'] as String?;
    user = (json['user'] as Map<String, dynamic>?) != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    labels = json['labels'] as List?;
    state = json['state'] as String?;
    locked = json['locked'] as bool?;
    assignee = json['assignee'];
    assignees = json['assignees'] as List?;
    milestone = json['milestone'];
    comments = json['comments'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    closedAt = json['closed_at'];
    authorAssociation = json['author_association'] as String?;
    activeLockReason = json['active_lock_reason'];
    body = json['body'] as String?;
    reactions = (json['reactions'] as Map<String, dynamic>?) != null
        ? Reactions.fromJson(json['reactions'] as Map<String, dynamic>)
        : null;
    timelineUrl = json['timeline_url'] as String?;
    performedViaGithubApp = json['performed_via_github_app'];
    score = json['score'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['url'] = url;
    json['repository_url'] = repositoryUrl;
    json['labels_url'] = labelsUrl;
    json['comments_url'] = commentsUrl;
    json['events_url'] = eventsUrl;
    json['html_url'] = htmlUrl;
    json['id'] = id;
    json['node_id'] = nodeId;
    json['number'] = number;
    json['title'] = title;
    json['user'] = user?.toJson();
    json['labels'] = labels;
    json['state'] = state;
    json['locked'] = locked;
    json['assignee'] = assignee;
    json['assignees'] = assignees;
    json['milestone'] = milestone;
    json['comments'] = comments;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['closed_at'] = closedAt;
    json['author_association'] = authorAssociation;
    json['active_lock_reason'] = activeLockReason;
    json['body'] = body;
    json['reactions'] = reactions?.toJson();
    json['timeline_url'] = timelineUrl;
    json['performed_via_github_app'] = performedViaGithubApp;
    json['score'] = score;
    return json;
  }
}

class Reactions {
  String? url;
  int? totalCount;
  int? plusOne;
  int? minusOne;
  int? laugh;
  int? hooray;
  int? confused;
  int? heart;
  int? rocket;
  int? eyes;

  Reactions({
    this.url,
    this.totalCount,
    this.plusOne,
    this.minusOne,
    this.laugh,
    this.hooray,
    this.confused,
    this.heart,
    this.rocket,
    this.eyes,
  });

  Reactions.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    totalCount = json['total_count'] as int?;
    plusOne = json['plusOne'] as int?;
    minusOne = json['minusOne'] as int?;
    laugh = json['laugh'] as int?;
    hooray = json['hooray'] as int?;
    confused = json['confused'] as int?;
    heart = json['heart'] as int?;
    rocket = json['rocket'] as int?;
    eyes = json['eyes'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['url'] = url;
    json['total_count'] = totalCount;
    json['plusOne'] = plusOne;
    json['minusOne'] = minusOne;
    json['laugh'] = laugh;
    json['hooray'] = hooray;
    json['confused'] = confused;
    json['heart'] = heart;
    json['rocket'] = rocket;
    json['eyes'] = eyes;
    return json;
  }
}

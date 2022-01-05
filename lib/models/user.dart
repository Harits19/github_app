class User {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;
  double? score;

  User({
    this.login,
    this.id,
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
    this.siteAdmin,
    this.score,
  });

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'] as String?;
    id = json['id'] as int?;
    nodeId = json['node_id'] as String?;
    avatarUrl = json['avatar_url'] as String?;
    gravatarId = json['gravatar_id'] as String?;
    url = json['url'] as String?;
    htmlUrl = json['html_url'] as String?;
    followersUrl = json['followers_url'] as String?;
    followingUrl = json['following_url'] as String?;
    gistsUrl = json['gists_url'] as String?;
    starredUrl = json['starred_url'] as String?;
    subscriptionsUrl = json['subscriptions_url'] as String?;
    organizationsUrl = json['organizations_url'] as String?;
    reposUrl = json['repos_url'] as String?;
    eventsUrl = json['events_url'] as String?;
    receivedEventsUrl = json['received_events_url'] as String?;
    type = json['type'] as String?;
    siteAdmin = json['site_admin'] as bool?;
    score = json['score'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['login'] = login;
    json['id'] = id;
    json['node_id'] = nodeId;
    json['avatar_url'] = avatarUrl;
    json['gravatar_id'] = gravatarId;
    json['url'] = url;
    json['html_url'] = htmlUrl;
    json['followers_url'] = followersUrl;
    json['following_url'] = followingUrl;
    json['gists_url'] = gistsUrl;
    json['starred_url'] = starredUrl;
    json['subscriptions_url'] = subscriptionsUrl;
    json['organizations_url'] = organizationsUrl;
    json['repos_url'] = reposUrl;
    json['events_url'] = eventsUrl;
    json['received_events_url'] = receivedEventsUrl;
    json['type'] = type;
    json['site_admin'] = siteAdmin;
    json['score'] = score;
    return json;
  }
}

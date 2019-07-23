import 'package:meta/meta.dart';

/*
pojo class that models data from github api v3
 */
class Developer {
  Developer({
    @required this.login,
    @required this.id,
    @required this.node_id,
    @required this.avatar_url,
    @required this.gravatar_id,
    @required this.url,
    @required this.html_url,
    @required this.followers_url,
    @required this.following_url,
    @required this.gists_url,
    @required this.starred_url,
    @required this.subscriptions_url,
    @required this.organizations_url,
    @required this.repos_url,
    @required this.events_url,
    @required this.received_events_url,
    @required this.type
  });

  Developer.map(dynamic map) {
    this.login = map['login'];
    this.id = map['id'];
    this.node_id = map['node_id'];
    this.avatar_url = map['avatar_url'];
    this.gravatar_id = map['gravatar_id'];
    this.url = map['url'];
    this.html_url = map['html_url'];
    this.followers_url = map['followers_url'];
    this.following_url = map['followering_url'];
    this.gists_url = map['gists_url'];
    this.starred_url = map['starred_url'];
    this.subscriptions_url = map['subscriptions_url'];
    this.organizations_url = map['organizations_url'];
    this.repos_url = map['repos_url'];
    this.events_url = map['events_url'];
    this.received_events_url = map['received_events_url'];
    this.type = map['type'];
  }

  String login;
  int id;
  String node_id;
  String avatar_url;
  String gravatar_id;
  String url;
  String html_url;
  String followers_url;
  String following_url;
  String gists_url;
  String starred_url;
  String subscriptions_url;
  String organizations_url;
  String repos_url;
  String events_url;
  String received_events_url;
  String type;

  String get getLogin => login;
  int get getId => id;
  String get getNode_id => node_id;
  String get getAvatar_url => avatar_url;
  String get getGravatar_id => gravatar_id;
  String get getUrl => url;
  String get getHtml_url => html_url;
  String get getFollowers_url => followers_url;
  String get getFollowing_url => following_url;
  String get getGists_url => gists_url;
  String get getStarred_url => starred_url;
  String get getSubscriptions_url => subscriptions_url;
  String get getOrganizations_url => organizations_url;
  String get getRepos_url => repos_url;
  String get getEvents_url => events_url;
  String get getReceived_events_url => received_events_url;
  String get getType => type;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['login'] = login;
    map['node_id'] = node_id;
    map['avatar_url'] = avatar_url;
    map['gravatar_id'] = gravatar_id;
    map['url'] = url;
    map['html_url'] = html_url;
    map['followers_url'] = followers_url;
    map['following_url'] = following_url;
    map['gists_url'] = gists_url;
    map['starred_url'] = starred_url;
    map['subscriptions_url'] = subscriptions_url;
    map['organizations_url'] = organizations_url;
    map['repos_url'] = repos_url;
    map['events_url'] = events_url;
    map['received_events_url'] = received_events_url;
    map['type'] = type;

    return map;
  }

  Developer.fromMap(Map<String, dynamic> map) {
    this.login = map['login'];
    this.id = map['id'];
    this.node_id = map['node_id'];
    this.avatar_url = map['avatar_url'];
    this.gravatar_id = map['gravatar_id'];
    this.url = map['url'];
    this.html_url = map['html_url'];
    this.followers_url = map['followers_url'];
    this.following_url = map['followering_url'];
    this.gists_url = map['gists_url'];
    this.starred_url = map['starred_url'];
    this.subscriptions_url = map['subscriptions_url'];
    this.organizations_url = map['organizations_url'];
    this.repos_url = map['repos_url'];
    this.events_url = map['events_url'];
    this.received_events_url = map['received_events_url'];
    this.type = map['type'];
  }

  factory Developer.fromJson(Map<String, dynamic> map) {
    return Developer(
        login: map['login'],
        id: map['id'],
        node_id: map['node_id'],
        avatar_url: map['avatar_url'],
        gravatar_id: map['gravatar_id'],
        url: map['url'],
        html_url: map['html_url'],
        followers_url: map['followers_url'],
        following_url: map['followering_url'],
        gists_url: map['gists_url'],
        starred_url: map['starred_url'],
        subscriptions_url: map['subscriptions_url'],
        organizations_url: map['organizations_url'],
        repos_url: map['repos_url'],
        events_url: map['events_url'],
        received_events_url: map['received_events_url'],
        type: map['type']
    );
  }

}

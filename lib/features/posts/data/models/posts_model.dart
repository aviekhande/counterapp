// ignore_for_file: unnecessary_getters_setters

class Posta {
  List<Posts>? _posts;
  int? _total;
  int? _skip;
  int? _limit;

  Posta({List<Posts>? posts, int? total, int? skip, int? limit}) {
    if (posts != null) {
      _posts = posts;
    }
    if (total != null) {
      _total = total;
    }
    if (skip != null) {
      _skip = skip;
    }
    if (limit != null) {
      _limit = limit;
    }
  }

  List<Posts>? get posts => _posts;
  set posts(List<Posts>? posts) => _posts = posts;
  int? get total => _total;
  set total(int? total) => _total = total;
  int? get skip => _skip;
  set skip(int? skip) => _skip = skip;
  int? get limit => _limit;
  set limit(int? limit) => _limit = limit;

  Posta.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      _posts = <Posts>[];
      json['posts'].forEach((v) {
        _posts!.add(Posts.fromJson(v));
      });
    }
    _total = json['total'];
    _skip = json['skip'];
    _limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_posts != null) {
      data['posts'] = _posts!.map((v) => v.toJson()).toList();
    }
    data['total'] = _total;
    data['skip'] = _skip;
    data['limit'] = _limit;
    return data;
  }
}

class Posts {
  int? _id;
  String? _title;
  String? _body;
  List<String>? _tags;
  Reactions? _reactions;
  int? _views;
  int? _userId;

  Posts(
      {int? id,
      String? title,
      String? body,
      List<String>? tags,
      Reactions? reactions,
      int? views,
      int? userId}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (body != null) {
      _body = body;
    }
    if (tags != null) {
      _tags = tags;
    }
    if (reactions != null) {
      _reactions = reactions;
    }
    if (views != null) {
      _views = views;
    }
    if (userId != null) {
      _userId = userId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get body => _body;
  set body(String? body) => _body = body;
  List<String>? get tags => _tags;
  set tags(List<String>? tags) => _tags = tags;
  Reactions? get reactions => _reactions;
  set reactions(Reactions? reactions) => _reactions = reactions;
  int? get views => _views;
  set views(int? views) => _views = views;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;

  Posts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _tags = json['tags'].cast<String>();
    _reactions = json['reactions'] != null
        ? Reactions.fromJson(json['reactions'])
        : null;
    _views = json['views'];
    _userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['body'] = _body;
    data['tags'] = _tags;
    if (_reactions != null) {
      data['reactions'] = _reactions!.toJson();
    }
    data['views'] = _views;
    data['userId'] = _userId;
    return data;
  }
}

class Reactions {
  int? _likes;
  int? _dislikes;

  Reactions({int? likes, int? dislikes}) {
    if (likes != null) {
      _likes = likes;
    }
    if (dislikes != null) {
      _dislikes = dislikes;
    }
  }

  int? get likes => _likes;
  set likes(int? likes) => _likes = likes;
  int? get dislikes => _dislikes;
  set dislikes(int? dislikes) => _dislikes = dislikes;

  Reactions.fromJson(Map<String, dynamic> json) {
    _likes = json['likes'];
    _dislikes = json['dislikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likes'] = _likes;
    data['dislikes'] = _dislikes;
    return data;
  }
}

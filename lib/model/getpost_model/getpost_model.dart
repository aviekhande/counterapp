class Post {
  List<PostElement> posts;
  int total;
  int skip;
  int limit;

  Post({
    required this.posts,
    required this.total,
    required this.skip,
    required this.limit,
  });
}

class PostElement {
  int id;
  String title;
  String body;
  List<dynamic> tags;
  Reactions reactions;
  int views;
  int userId;

  PostElement(post, {
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });
}

class Reactions {
  int likes;
  int dislikes;

  Reactions({
    required this.likes,
    required this.dislikes,
  });
}

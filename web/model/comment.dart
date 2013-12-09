part of dart_blog;

class Comment {
  int id;
  String author;
  String message;
  int article_id;

  Comment(this.id, this.author, this.message, this.article_id);

  String toJsonString() {
    Map data = {
                "comment": {
                  "author" : author,
                  "message" : message,
                  "article_id" : article_id
                  }
                };
    return JSON.encode(data);
  }

  factory Comment.fromJsonMap(Map json) {
    return new Comment(json['id'], json['author'], json['message'], json['article_id']);
  }
}

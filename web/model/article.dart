part of dart_blog;

class Article {
  int id;
  String author;
  String title;
  String content;
  List comments = new List();
  
  Article(this.id, this.author, this.title, this.content, this.comments);

  String toJsonString() {
    Map data = {
                "article": {
                  "author" : author,
                  "title" : title,
                  "content" : content
                  }
                };
    return JSON.encode(data);
  }

  factory Article.fromJsonMap(Map json) {
    return new Article(json['id'], json['author'], json['title'], json['content'], json['comments']);
  }
}

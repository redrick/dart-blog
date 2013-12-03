part of dart_blog;

class Article {
  int id;
  String author;
  String title;
  String content;

  Article(this.id, this.author, this.title, this.content);

  String toJsonString() {
    Map data = {
                "id" : id,
                "author" : author,
                "title" : title,
                "content" : content
    };
    return JSON.encode(data);
  }

  factory Article.fromJsonMap(Map json) {
    return new Article(json['id'], json['author'], json['title'],
        json['content']);
  }
}

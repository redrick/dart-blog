part of dart_blog;

class QueryService {
  String _articlesUrl = 'http://test.antasandrej.net/articles.json';
  String _articleUrl = 'http://test.antasandrej.net/articles/';
  
  Article _articleResult = new Article(0, '', '', '');
  
  int _pageNumber = 1;

  Future _loaded;

  Map<int, Article> _articlesCache;

  Http _http;

  QueryService(Http this._http) {
    _loaded = Future.wait([_loadArticles()]);
  }

  Future _loadArticles() {
    return _http.get(_articlesUrl+'?page='+_pageNumber.toString())
      .then((HttpResponse response) {
        _articlesCache = new Map();
        for (Map article in response.data) {
          Article a = new Article.fromJsonMap(article);
          _articlesCache[a.id] = a;
        }
      });
  }

  Future<Article> getArticleById(int id) {
      return _http.get(_articleUrl+id.toString()+".json")
        .then((HttpResponse response) {
           Map articleMap = response.data;
           _articleResult = new Article.fromJsonMap(articleMap);
           return _articleResult;
        });
//    return new Future.value(_articleResult);
  }

  Future<Map<String, Article>> getAllArticles(int pageNumber) {
    _pageNumber = pageNumber;
      return _http.get(_articlesUrl+'?page='+_pageNumber.toString())
          .then((HttpResponse response) {
            _articlesCache = new Map();
            for (Map article in response.data) {
              Article a = new Article.fromJsonMap(article);
              _articlesCache[a.id] = a;
            }
            return _articlesCache;
          });
//    return new Future.value(_articlesCache);
  }
  
  Future<Article> createArticle(String data) {
    return _http.post(_articlesUrl, data)
      .then((HttpResponse response) {
        Map articleMap = response.data;
        _articleResult = new Article.fromJsonMap(articleMap);
        return _articleResult;
      });
//    return new Future.value(_articleResult);
  }
  
  Future<Article> updateArticle(int id, String data) {
    if (_http.put(_articleUrl+id.toString()+".json", data) == null) {
      return this.getArticleById(id);
    }
    return new Future.value(this.getArticleById(id));
  }
}

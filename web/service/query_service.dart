part of dart_blog;

class QueryService {
  String _articlesUrl = 'http://test.antasandrej.net/articles.json';
  String _articlesUpdateUrl = 'http://test.antasandrej.net/articles/';
  
  Article _articleResult;
  
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
    if (_articlesCache == null) {
      return _loaded.then((_) {
        return _articlesCache[id];
      });
    }
    return new Future.value(_articlesCache[id]);
  }

  Future<Map<String, Article>> getAllArticles(int pageNumber) {
    _pageNumber = pageNumber;
    if (_articlesCache == null) {
      return _http.get(_articlesUrl+'?page='+_pageNumber.toString())
          .then((HttpResponse response) {
            _articlesCache = new Map();
            for (Map article in response.data) {
              Article a = new Article.fromJsonMap(article);
              _articlesCache[a.id] = a;
            }
            return _articlesCache;
          });
    }
    return new Future.value(_articlesCache);
  }
  
  Future<Article> createArticle(String data) {
    _http.post(_articlesUrl, data)
      .then((HttpResponse response) {
        Map articleMap = response.data;
        _articleResult = new Article.fromJsonMap(articleMap);
        return _articleResult;
      });
    return new Future.value(_articleResult);
  }
  

  Future<Article> updateArticle(int id, String data) {
    if (_http.put(_articlesUpdateUrl+id.toString()+".json", data) == null) {
      return this.getArticleById(id);
    }
    return new Future.value(this.getArticleById(id));
  }
}

part of dart_blog;

class QueryService {
  String _articlesUrl = 'http://test.antasandrej.net/articles.json';

  Future _loaded;

  Map<String, Article> _articlesCache;

  Http _http;

  QueryService(Http this._http) {
    _loaded = Future.wait([_loadArticles()]);
  }

  Future _loadArticles() {
    return _http.get(_articlesUrl)
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

  Future<Map<String, Article>> getAllArticles() {
    if (_articlesCache == null) {
      return _loaded.then((_) {
        return _articlesCache;
      });
    }
    return new Future.value(_articlesCache);
  }
}

class UpdateService {
  String _articlesUpdateUrl = 'http://test.antasandrej.net/articles.json';

  Future _updated;

  Http _http;

  UpdateService(Http this._http) {
    _updated = Future.wait([_updateArticle()]);
  }

  Future _updateArticle() {
    return _http.post(_articlesUpdateUrl)
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

}
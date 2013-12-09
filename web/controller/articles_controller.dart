part of dart_blog;

@NgController(
    selector: '[article-index]',
    publishAs: 'ctrl')
class IndexArticleController {

  static const String LOADING_MESSAGE = "Loading articles...";
  static const String ERROR_MESSAGE = """Failed to load resource!""";

  Http _http;
  
  QueryService _queryService;
  QueryService get queryService => _queryService;

  String message = LOADING_MESSAGE;
  bool articlesLoaded = false;
  int pageNumber = 1;

  Map<String, Article> _articleMap = {};
  get articleMap => _articleMap;
  get allArticles => _articleMap.values.toList();

  IndexArticleController(Http this._http, QueryService this._queryService, RouteProvider routeProvider) {
    if (routeProvider.parameters['pageNumber'] != null) {
      pageNumber = int.parse(routeProvider.parameters['pageNumber']);
    } else {
      pageNumber = 1;
    }
    _loadData(pageNumber);
  }

  void _loadData(int pageNumber) {   
    
    _queryService.getAllArticles(pageNumber)
      .then((Map<String, Article> allArticles) {
        _articleMap = allArticles;
        articlesLoaded = true;
      },
      onError: (Object obj) {
        articlesLoaded = false;
        message = ERROR_MESSAGE;
      });
  }
}

@NgController(
    selector: '[article-show]',
    publishAs: 'ctrl')
class ShowArticleController {

  static const String LOADING_MESSAGE = "Loading articles...";
  static const String ERROR_MESSAGE = """Failed to load resource!""";

  Http _http;
  
  QueryService _queryService;
  QueryService get queryService => _queryService;

  int _articleId;
  String message = LOADING_MESSAGE;
  bool articleLoaded = false;

  Article _article = new Article(0, '','','');
  get article => _article;

  ShowArticleController(Http this._http, QueryService this._queryService, RouteProvider routeProvider) {
    _articleId = int.parse(routeProvider.parameters['articleId']);
    _loadData();
  }

  void _loadData() {   
    _queryService.getArticleById(this._articleId)
      .then((Article article) {
        _article = article;
        articleLoaded = true;
      },
      onError: (Object obj) {
        articleLoaded = false;
        message = ERROR_MESSAGE;
      });
  }
}


@NgController(
    selector: '[article-edit]',
    publishAs: 'ctrl')
class EditArticleController {

  static const String LOADING_MESSAGE = "Loading articles...";
  static const String ERROR_MESSAGE = """Failed to load resource!""";

  Http _http;
  
  QueryService _queryService;
  QueryService get queryService => _queryService;

  int _articleId;
  String message = LOADING_MESSAGE;
  bool articleLoaded = false;

  Article _article = new Article(0, '','','');
  get article => _article;

  EditArticleController(Http this._http, QueryService this._queryService, RouteProvider routeProvider) {
    _articleId = int.parse(routeProvider.parameters['articleId']);
    _loadData();
  }

  void _loadData() {   
    _queryService.getArticleById(this._articleId)
      .then((Article article) {
        _article = article;
        articleLoaded = true;
      },
      onError: (Object obj) {
        articleLoaded = false;
        message = ERROR_MESSAGE;
      });
  }
}

@NgController(
    selector: '[article-new]',
    publishAs: 'ctrl')
class NewArticleController {
  Article article;
  
  NewArticleController() {
     article = new Article(0, '','','');
  }
  
}

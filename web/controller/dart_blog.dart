part of dart_blog;

@NgController(
    selector: '[dart-blog]',
    publishAs: 'ctrl')
class DartBlogController {

  static const String LOADING_MESSAGE = "Loading articles...";
  static const String ERROR_MESSAGE = """Failed to load resource!""";

  Http _http;
  
  QueryService _queryService;
  QueryService get queryService => _queryService;

  String message = LOADING_MESSAGE;
  bool articlesLoaded = false;

  Map<String, Article> _articleMap = {};
  get articleMap => _articleMap;
  get allArticles => _articleMap.values.toList();

  DartBlogController(Http this._http, QueryService this._queryService) {
    _loadData();
  }

  void _loadData() {    
    _queryService.getAllArticles()
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

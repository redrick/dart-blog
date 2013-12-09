part of dart_blog;

@NgComponent(
    selector: 'form-article',
    templateUrl: 'component/article/form/form_article_component.html',
    cssUrl: 'style.css',
    publishAs: 'ctrl',
    map: const {
      'article-row':'<=>articleRow'
    }
)
class FormArticleComponent {
  Article articleRow;
  Article _article = new Article(0, '','','');
  
  Http _http;
  
  QueryService _queryService;
  QueryService get queryService => _queryService;
  
  int _articleId;

  Router router;

  get article {
    return articleRow;
  }
  
  FormArticleComponent(Http this._http, QueryService this._queryService, RouteProvider routeProvider, this.router) {}
  
  update(){
    _queryService.updateArticle(articleRow.id, articleRow.toJsonString())
      .then((Article articleResult) {
        _article = articleResult;
        router.go("articles.show", {"articleId": _article.id});
      }); 
  }

  create(){
    _queryService.createArticle(articleRow.toJsonString())
      .then((Article articleResult) {
        _article = articleResult;

        print(_article.id);
        router.go("articles.show", {"articleId": _article.id});
      });
  }

}

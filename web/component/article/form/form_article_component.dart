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

  get article {
    return articleRow;
  }
  
  FormArticleComponent(Http this._http, QueryService this._queryService, RouteProvider routeProvider) {}
  
  update(){
    print('upravujem');
    
    _queryService.updateArticle(articleRow.id, articleRow.toJsonString())
      .then((Article articleResult) {
        _article = articleResult;
      });
    
  }
  

  create(){
    print('vytvaram');
    
    _queryService.createArticle(articleRow.toJsonString())
      .then((Article articleResult) {
        _article = articleResult;
      });
  }

}

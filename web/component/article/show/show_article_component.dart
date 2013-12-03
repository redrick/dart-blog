part of dart_blog;

@NgComponent(
    selector: 'show-article',
    templateUrl: 'component/article/show/show_article_component.html',
    cssUrl: 'style.css',
    publishAs: 'ctrl',
    map: const {
      'article-map':'<=>articleMap'
    }
)
class ShowArticleComponent {
  Map<String, Article> articleMap;
  String _articleId;

  get article {
    int article_id = int.parse(_articleId);
    return articleMap[article_id];
  }

  ShowArticleComponent(RouteProvider routeProvider) {
    _articleId = routeProvider.parameters['articleId'];
  }
}

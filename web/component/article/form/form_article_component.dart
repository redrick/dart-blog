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

  get article {
    return articleRow;
  }

  create(){
    print('safsfas');
  }
  
  FormArticleComponent(RouteProvider routeProvider) {}
}

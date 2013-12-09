part of dart_blog;

@NgComponent(
    selector: 'form-comment',
    templateUrl: 'component/comment/form/form_comment_component.html',
    cssUrl: 'style.css',
    publishAs: 'ctrl',
    map: const {
      'comment-row':'<=>commentRow',
      'article-id':'<=>articleId',
    }
)
class FormCommentComponent {
  Comment commentRow;
  Article _article;
  int articleId;
  
  Comment _comment = new Comment(0, '','', 0);
  
  
  Http _http;
  
  QueryService _queryService;
  QueryService get queryService => _queryService;

  Router router;
  
  get article_view_id {
    return articleId;
  }
    
  get comment {
    _comment.article_id = this.article_view_id;
    return _comment;
  }
  
  FormCommentComponent(Http this._http, QueryService this._queryService, this.router) {}
  
  createComment(){
    _queryService.createComment(this.article_view_id, _comment.toJsonString())
      .then((Article article) {
        _article = article;
        
        router.go("articles.show", {"articleId": _article.id}, replace: true);
      });
  }

}

part of dart_blog;

class DartBlogRouteInitializer implements RouteInitializer {

  init(Router router, ViewFactory view) {
    router.root
      ..addRoute(
        name: 'view_default',
        defaultRoute: true,
        enter: (_) =>
            router.go('index', {}, replace:true))
      
      ..addRoute(
        name: 'index',
        path: '/index',
        enter: view('view/article/index.html'))
            
      ..addRoute(
        name: 'index_with_page',
        path: '/index/:pageNumber',
        enter: view('view/article/index.html'))
      
      ..addRoute(
        name: 'new',
        path: '/articles/new',
        enter: view('view/article/new.html'))
        
      ..addRoute(
        name: 'articles',
        path: '/articles/:articleId',
        mount: (Route route) => route
          ..addRoute(
            name: 'show',
            path: '/show',
            enter: view('view/article/show.html'))
          ..addRoute(
            name: 'edit',
            path: '/edit',
            enter: view('view/article/edit.html'))
    );
  }
}

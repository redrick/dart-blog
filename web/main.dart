library dart_blog;

import 'dart:async';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:di/di.dart';
import 'package:logging/logging.dart';
import 'package:perf_api/perf_api.dart';

part 'service/query_service.dart';
part 'model/article.dart';
part 'controller/dart_blog.dart';
part 'routing/dart_blog_router.dart';
part 'component/article/show/show_article_component.dart';


class MyAppModule extends Module {
  MyAppModule() {
    type(DartBlogController);
//    type(RatingComponent);
    type(QueryService);
    type(ShowArticleComponent);
    type(Profiler, implementedBy: Profiler); // comment out to enable profiling
    type(RouteInitializer, implementedBy: DartBlogRouteInitializer);
    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));
  }
}

main() {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  ngBootstrap(module: new MyAppModule());
}

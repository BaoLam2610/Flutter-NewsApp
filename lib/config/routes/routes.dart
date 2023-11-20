import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail/article_detail_page.dart';
import 'package:news_app/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app/features/daily_news/presentation/pages/saved_articles/saved_articles_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case dailyNewsPage:
        return _materialRoute(const DailyNews());
      case articleDetailPage:
        return _materialRoute(
          ArticleDetailPage(
            article: settings.arguments as ArticleEntity,
          ),
        );
      case savedArticlesPage:
        return _materialRoute(const SavedArticlesPage());
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}

const String dailyNewsPage = '/';
const String articleDetailPage = '/ArticleDetail';
const String savedArticlesPage = '/SavedArticles';

// enum Screen {
//   dailyNews('/'),
//   articleDetail('/ArticleDetail'),
//   savedArticles('/SavedArticles');
//   const Screen(this.route);
//   final String route;
// }

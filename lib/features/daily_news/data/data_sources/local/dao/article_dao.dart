import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertArticle(ArticleModel data);

  @delete
  Future<void> deleteArticle(ArticleModel data);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();
}

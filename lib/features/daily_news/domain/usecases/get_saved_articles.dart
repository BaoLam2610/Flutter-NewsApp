import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _repository;

  GetSavedArticlesUseCase(this._repository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _repository.getSavedArticles();
  }
}

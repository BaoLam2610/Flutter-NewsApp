import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetArticlesUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _repository;

  GetArticlesUseCase(this._repository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _repository.getNewsArticles();
  }
}

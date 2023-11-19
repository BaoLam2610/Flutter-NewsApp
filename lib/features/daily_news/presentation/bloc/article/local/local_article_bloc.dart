import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticlesBloc
    extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArtcle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticlesUseCase.call();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(
    SaveArticle event,
    Emitter<LocalArticlesState> emit,
  ) async {
    await _saveArticleUseCase(params: event.article);
    final articles = await _getSavedArticlesUseCase.call();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArtcle(
    RemoveArticle event,
    Emitter<LocalArticlesState> emit,
  ) async {
    await _removeArticleUseCase(params: event.article);
    final articles = await _getSavedArticlesUseCase.call();
    emit(LocalArticlesDone(articles));
  }
}

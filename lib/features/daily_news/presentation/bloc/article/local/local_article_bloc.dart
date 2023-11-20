import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/bloc/base_bloc.dart';
import 'package:news_app/core/bloc/base_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';

class LocalArticlesBloc extends BaseBloc<LocalArticlesEvent, BlocState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) : super(Loading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArtcle);
  }

  Future<void> _getSavedArticles(Emitter<BlocState> emit) async {
    final articles = await _getSavedArticlesUseCase.call();
    emit(Success(data: articles));
  }

  void onGetSavedArticles(
    GetSavedArticles event,
    Emitter<BlocState> emit,
  ) async {
    await _getSavedArticles(emit);
  }

  void onSaveArticle(
    SaveArticle event,
    Emitter<BlocState> emit,
  ) async {
    await _saveArticleUseCase(params: event.article);
    await _getSavedArticles(emit);
  }

  void onRemoveArtcle(
    RemoveArticle event,
    Emitter<BlocState> emit,
  ) async {
    await _removeArticleUseCase(params: event.article);
    await _getSavedArticles(emit);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticlesUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
    GetArticles event,
    Emitter<RemoteArticleState> emit,
  ) async {
    final dataState = await _getArticlesUseCase.call();

    if (dataState is DataSuccess && dataState.data?.isNotEmpty == true) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataError) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/bloc/base_bloc.dart';
import 'package:news_app/core/bloc/base_state.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';

class RemoteArticlesBloc extends BaseBloc<RemoteArticleEvent, BlocState> {
  final GetArticlesUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase) : super(Initialize()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
    GetArticles event,
    Emitter<BlocState> emit,
  ) async {
    emit(Loading());
    final dataState = await _getArticlesUseCase.call();
    if (dataState is DataSuccess && dataState.data?.isNotEmpty == true) {
      emit(Success(data: dataState.data!));
    }

    if (dataState is DataError) {
      emit(
        Error(message: dataState.error?.message ?? ''),
      );
    }
  }
}

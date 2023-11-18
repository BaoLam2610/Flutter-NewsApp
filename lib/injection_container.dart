import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Api service
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repository
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  // Use case
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));

  // Bloc
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app/core/bloc/base_state.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/injection_container.dart';

import '../../../../../config/routes/routes.dart';
import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';

class SavedArticlesPage extends HookWidget {
  const SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<LocalArticlesBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Saved articles'),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalArticlesBloc, BlocState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is Success) {
          if (state.data!.isEmpty) {
            return Center(
              child: Text(
                'This is no data',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return ListView.builder(
            itemCount: state.data!.length,
            itemBuilder: (context, index) {
              final article = state.data![index];
              return ArticleTile(
                article: article,
                isRemovable: true,
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
                onArticleRemove: (article) =>
                    _onArticleRemove(context, article),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, articleDetailPage, arguments: article);
  }

  void _onArticleRemove(BuildContext context, ArticleEntity article) {
    context.read<LocalArticlesBloc>().add(RemoveArticle(article));
  }
}

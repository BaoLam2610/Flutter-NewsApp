import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/core/bloc/base_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

import '../../../../../injection_container.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Daily News'),
      actions: [
        IconButton(
          onPressed: () => _onOpenSavedArticlesButtonTapped(context),
          icon: const Icon(Icons.bookmark),
        )
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, BlocState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is Success) {
          return RefreshIndicator(
            onRefresh: () {
              return _loadNewsData(context);
            },
            child: ListView.builder(
              itemCount: state.data!.length,
              itemBuilder: (context, index) {
                final article = state.data![index];
                return ArticleTile(
                  article: article,
                  onArticlePressed: (article) =>
                      _onArticlePressed(context, article),
                );
              },
            ),
          );
        }

        if (state is Error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(state.message),
                IconButton(
                    onPressed: () {
                      context
                          .read<RemoteArticlesBloc>()
                          .add(const GetArticles());
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Future<void> _loadNewsData(BuildContext context) async {
    context.read<RemoteArticlesBloc>().add(const GetArticles());
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, articleDetailPage, arguments: article);
  }

  void _onOpenSavedArticlesButtonTapped(BuildContext context) {
    Navigator.pushNamed(context, savedArticlesPage);
  }
}

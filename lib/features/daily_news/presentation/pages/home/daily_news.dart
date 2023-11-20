import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
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
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index) {
              final article = state.articles![index];
              return ArticleTile(
                article: article,
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
          );
        }

        if (state is RemoteArticlesError) {
          return Center(
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          );
        }

        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, articleDetailPage, arguments: article);
  }

  void _onOpenSavedArticlesButtonTapped(BuildContext context) {
    Navigator.pushNamed(context, savedArticlesPage);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';

import '../../../../../injection_container.dart';

class ArticleDetailPage extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailPage({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocalArticlesBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(context),
          _buildArticleImage(),
          _buildArticleDescription(
            context,
          )
        ],
      ),
    );
  }

  _buildArticleTitleAndDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          Text(
            article!.title ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.timeline_outlined,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                article!.publishedAt!,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
    );
  }

  _buildArticleImage() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.all(14),
      child: Image.network(
        article!.urlToImage!,
        fit: BoxFit.cover,
      ),
    );
  }

  _buildArticleDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article!.description ?? ''}\n\n${article!.content ?? ''}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(
          Icons.bookmark_add,
          size: 16,
        ),
      ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    context.read<LocalArticlesBloc>().add(SaveArticle(article!));
    // BlocProvider.of<LocalArticlesBloc>(context).add(SaveArticle(_article));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article saved successfully!'),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}

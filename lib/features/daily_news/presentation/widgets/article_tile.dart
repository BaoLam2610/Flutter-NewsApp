import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  final ArticleEntity article;
  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [
          _buildImage(),
          _buildTitleAndDescription(context),
        ],
      ),
    );
  }

  _layoutImage(
    BuildContext context, {
    Widget? child,
    DecorationImage? decorationImage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            image: decorationImage,
          ),
          child: child,
        ),
      ),
    );
  }

  _buildImage() {
    return CachedNetworkImage(
      imageUrl: article.urlToImage!,
      imageBuilder: (context, imageProvider) {
        return _layoutImage(
          context,
          decorationImage: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return _layoutImage(
          context,
          child: const CupertinoActivityIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return _layoutImage(
          context,
          child: const Icon(Icons.error),
        );
      },
    );
  }

  _buildTitleAndDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Text(
              article.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                article.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article.publishedAt ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

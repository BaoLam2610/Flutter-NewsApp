import 'package:news_app/core/bloc/base_event.dart';

abstract class RemoteArticleEvent extends BlocEvent {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}

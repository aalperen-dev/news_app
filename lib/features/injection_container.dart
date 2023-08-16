import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/data/repository/article_repository_impl.dart';
import 'package:news_app/features/domain/repository/article_repository.dart';
import 'package:news_app/features/domain/usercases/get_article.dart';
import 'package:news_app/features/presentation/bloc/article/remote/remote_articte_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // dio
  sl.registerSingleton<Dio>(Dio());
  // dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  // use cases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  // blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
}

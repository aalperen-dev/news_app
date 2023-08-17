import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/data/repository/article_repository_impl.dart';
import 'package:news_app/features/domain/repository/article_repository.dart';
import 'package:news_app/features/domain/usercases/get_article.dart';
import 'package:news_app/features/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'data/data_sources/local/app_database.dart';
import 'domain/usercases/get_saved_article.dart';
import 'domain/usercases/remove_article.dart';
import 'domain/usercases/save_article.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  //UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));
}

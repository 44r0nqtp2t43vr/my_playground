import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_playground/features/bluetooth_connect/data/controllers/ble_controller.dart';
import 'package:my_playground/features/bluetooth_connect/data/repository/device_repository_impl.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/get_scanres.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/get_services.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/refresh_services.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/restart_stream.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/stream_data.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/update_chara.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/device/remote/remote_device_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_bloc.dart';
import 'package:my_playground/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:my_playground/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:my_playground/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:my_playground/features/daily_news/domain/repository/article_repository.dart';
import 'package:my_playground/features/daily_news/domain/usecases/get_article.dart';
import 'package:my_playground/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:my_playground/features/daily_news/domain/usecases/remove_article.dart';
import 'package:my_playground/features/daily_news/domain/usecases/save_article.dart';
import 'package:my_playground/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:my_playground/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // build database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<BleController>(BleController());

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  sl.registerSingleton<DeviceRepository>(DeviceRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  sl.registerSingleton<GetScanresUseCase>(GetScanresUseCase(sl()));

  sl.registerSingleton<GetServicesUseCase>(GetServicesUseCase(sl()));

  sl.registerSingleton<RefreshServicesUseCase>(RefreshServicesUseCase(sl()));

  sl.registerSingleton<UpdateCharaUseCase>(UpdateCharaUseCase(sl()));

  sl.registerSingleton<StreamDataUseCase>(StreamDataUseCase(sl()));

  sl.registerSingleton<RestartStreamUseCase>(RestartStreamUseCase(sl()));

  // Blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));

  sl.registerFactory<RemoteDevicesBloc>(() => RemoteDevicesBloc(sl()));

  sl.registerFactory<RemoteServicesBloc>(
      () => RemoteServicesBloc(sl(), sl(), sl(), sl()));
}

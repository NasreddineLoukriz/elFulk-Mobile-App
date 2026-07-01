import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:elfulk/src/core/config/app_environment.dart';
import 'package:elfulk/src/core/networking/app/app_api_service.dart';
import 'package:elfulk/src/core/networking/child/child_api_service.dart';
import 'package:elfulk/src/core/networking/helper/api_constants.dart';
import 'package:elfulk/src/core/networking/helper/dio_factory.dart';
import 'package:elfulk/src/core/networking/parent/parent_api_service.dart';
import 'package:elfulk/src/features/app_features/architecture/data/repos/architecture_repository.dart';
import 'package:elfulk/src/features/app_features/architecture/logic/cubit/architecture_cubit.dart';
import 'package:elfulk/src/features/app_features/home/data/repos/home_repository.dart';
import 'package:elfulk/src/features/app_features/home/logic/cubit/home_cubit.dart';
import 'package:elfulk/src/features/child_features/child_home/data/repos/child_home_repository.dart';
import 'package:elfulk/src/features/child_features/child_home/logic/cubit/child_home_cubit.dart';
import 'package:elfulk/src/features/parent_features/parent_home/data/repos/parent_home_repository.dart';
import 'package:elfulk/src/features/parent_features/parent_home/logic/cubit/parent_home_cubit.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/data/repos/parent_requests_repository.dart';
import 'package:elfulk/src/features/parent_features/parent_requests/logic/bloc/parent_requests_bloc.dart';
import 'package:elfulk/src/core/theme/logic/cubit/theme_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt(AppEnvironment environment) async {
  await getIt.reset();
  configureApiBaseUrl(environment);
  DioFactory.reset();

  final Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<AppEnvironment>(() => environment);
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<AppApiService>(
    () => AppApiService(getIt<Dio>(), baseUrl: apiBaseUrl),
  );
  getIt.registerLazySingleton<ParentApiService>(
    () => ParentApiService(getIt<Dio>(), baseUrl: apiBaseUrl),
  );
  getIt.registerLazySingleton<ChildApiService>(
    () => ChildApiService(getIt<Dio>(), baseUrl: apiBaseUrl),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(getIt<AppApiService>()),
  );
  getIt.registerLazySingleton<ParentHomeRepository>(
    () => ParentHomeRepository(getIt<ParentApiService>()),
  );
  getIt.registerLazySingleton<ParentRequestsRepository>(
    () => ParentRequestsRepository(getIt<ParentApiService>()),
  );
  getIt.registerLazySingleton<ChildHomeRepository>(
    () => ChildHomeRepository(getIt<ChildApiService>()),
  );
  getIt.registerLazySingleton<ArchitectureRepository>(
    () => ArchitectureRepository(getIt<AppEnvironment>()),
  );

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));
  getIt.registerFactory<ParentHomeCubit>(
    () => ParentHomeCubit(getIt<ParentHomeRepository>()),
  );
  getIt.registerFactory<ParentRequestsBloc>(
    () => ParentRequestsBloc(getIt<ParentRequestsRepository>()),
  );
  getIt.registerFactory<ChildHomeCubit>(
    () => ChildHomeCubit(getIt<ChildHomeRepository>()),
  );
  getIt.registerFactory<ArchitectureCubit>(
    () => ArchitectureCubit(getIt<ArchitectureRepository>()),
  );

  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
}




import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:todo/core/pagesAndViewModels/home/HomeModel.dart';
import 'package:todo/Logger.dart';
import 'package:todo/core/pagesAndViewModels/todo/TodoModel.dart';
import 'package:todo/core/services/ApiFetcher.dart';
import 'package:todo/core/services/ErrorService.dart';
import 'package:todo/core/services/NavigationService.dart';
import 'package:todo/core/services/TodoService.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  Logger log = getLogger("setUpLocator");

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => TodoModel());

  locator.registerLazySingleton(() => ApiFetcher());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => TodoService());
  locator.registerLazySingleton(() => ErrorService());
}
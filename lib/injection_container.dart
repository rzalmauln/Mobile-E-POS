import 'package:e_pos/cubit/store/cubit_store.dart';
import 'package:e_pos/data/faker/store_factory.dart';
import 'package:e_pos/data/helper/database_helper.dart';
import 'package:e_pos/data/services/store_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  final DatabaseHelper database = DatabaseHelper();
  sl.registerSingleton(database);
  sl.registerLazySingleton(() => StoreService());
  sl.registerFactory(() => StoreCubit(storeService: sl()));
  await sl.allReady();
}

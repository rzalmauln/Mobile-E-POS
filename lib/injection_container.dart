import 'package:e_pos/cubits/login/login_cubit.dart';
import 'package:e_pos/cubits/register/register_cubit.dart';
import 'package:e_pos/cubits/store/cubit_store.dart';
import 'package:e_pos/data/helper/database_helper.dart';
import 'package:e_pos/data/services/store_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  final DatabaseHelper database = DatabaseHelper();
  sl.registerSingleton(database);
  sl.registerLazySingleton(() => StoreService());
  sl.registerFactory(() => StoreCubit(storeService: sl()));
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => RegisterCubit());
  await sl.allReady();
}

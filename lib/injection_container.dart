import 'package:e_pos/cubits/cart/cart_cubit.dart';
import 'package:e_pos/cubits/login/login_cubit.dart';
import 'package:e_pos/cubits/order/order_cubit.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_cubit.dart';
import 'package:e_pos/cubits/product/product_cubit.dart';
import 'package:e_pos/cubits/register/register_cubit.dart';
import 'package:e_pos/cubits/store/store_cubit.dart';
import 'package:e_pos/data/helper/database_helper.dart';
import 'package:e_pos/data/services/order_detail_service.dart';
import 'package:e_pos/data/services/order_service.dart';
import 'package:e_pos/data/services/product_service.dart';
import 'package:e_pos/data/services/store_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  final DatabaseHelper database = DatabaseHelper();
  sl.registerSingleton(database);
  sl.registerLazySingleton(() => StoreService());
  sl.registerLazySingleton(() => ProductService());
  sl.registerLazySingleton(() => OrderService());
  sl.registerLazySingleton(() => OrderDetailService());
  sl.registerFactory(() => StoreCubit(sl()));
  sl.registerFactory(() => ProductCubit(sl()));

  sl.registerFactory(() => CartCubit());
  sl.registerFactory(() => OrderCubit(sl(), sl()));
  sl.registerFactory(() => OrderDetailCubit(sl()));
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => RegisterCubit());
  await sl.allReady();
}

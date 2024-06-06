import 'package:bloc/bloc.dart';
import 'package:e_pos/cubits/store/store_state.dart';
import 'package:e_pos/data/model/store/store.dart';
import 'package:e_pos/data/services/store_service.dart';

class StoreCubit extends Cubit<StoreCubitState> {
  StoreCubit(this.storeService) : super(InitialCubitState()) {
    loadStores();
  }

  final StoreService storeService;

  void loadStores() async {
    emit(LoadingCubitState());
    try {
      final stores = await storeService.getStores();
      emit(LoadedCubitState(stores));
    } catch (e) {
      emit(ErrorCubitState(e.toString()));
    }
  }

  void addStore(Store store) async {
    emit(LoadingCubitState());
    try {
      await storeService.insertStore(store);
      loadStores();
    } catch (e) {
      emit(ErrorCubitState(e.toString()));
    }
  }

  void updateStore(Store store) async {
    emit(LoadingCubitState());
    try {
      await storeService.updateStore(store);
      loadStores();
    } catch (e) {
      emit(ErrorCubitState(e.toString()));
    }
  }

  void deleteStore(int id) async {
    emit(LoadingCubitState());
    try {
      await storeService.deleteStore(id);
      loadStores();
    } catch (e) {
      emit(ErrorCubitState(e.toString()));
    }
  }
}

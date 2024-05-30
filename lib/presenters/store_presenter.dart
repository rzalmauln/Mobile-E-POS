import '../data/model/store/store.dart';
import '../data/services/store_service.dart';
import '../views/store_view.dart';

class StorePresenter {
  final StoreView _view;
  final StoreService _storeService = StoreService();

  StorePresenter(this._view);

  void loadStores() async {
    _view.showLoading();
    try {
      final stores = await _storeService.getStores();
      _view.showStores(stores!);
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  void addStore(Store store) async {
    await _storeService.insertStore(store);
    loadStores();
  }

  void updateStore(Store store) async {
    await _storeService.updateStore(store);
    loadStores();
  }

  void deleteStore(int id) async {
    await _storeService.deleteStore(id);
    loadStores();
  }
}

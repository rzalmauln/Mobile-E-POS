import '../../data/model/store/store.dart';

abstract class StoreView {
  void showLoading();
  void showStores(List<Store> stores);
  void showError(String message);
}

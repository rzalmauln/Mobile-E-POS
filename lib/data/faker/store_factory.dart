import 'package:e_pos/data/helper/model_faker.dart';
import 'package:e_pos/data/model/store/store.dart';
import 'package:e_pos/data/services/store_service.dart';

class StoreFactory extends ModelFaker<Store> {
  int _currentId = 0;
  final StoreService _storeService = StoreService();

  int _getLastId() {
    if (_storeService.getStores() != null) {
      _currentId = _storeService.getLastIdStore() as int;
      return _currentId++;
    } else {
      return _currentId++;
    }
  }

  @override
  Store generateFake() {
    return Store(
      id: _getLastId(),
      name: faker.company.name(),
      username: faker.person.random.string(10),
      password: faker.internet.password(length: 10),
    );
  }

  @override
  List<Store> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

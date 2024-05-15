import 'package:flutter/material.dart';
import '../data/model/store/store.dart';
import '../presenters/store_presenter.dart';
import 'store_view.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> implements StoreView {
  late StorePresenter _presenter;
  List<Store> _stores = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = StorePresenter(this);
    _presenter.loadStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stores'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  itemCount: _stores.length,
                  itemBuilder: (context, index) {
                    final store = _stores[index];
                    return ListTile(
                      title: Text('Store ID: ${store.id}'),
                      subtitle: Text(
                          'Username: ${store.username}\nLocation: ${store.password}'),
                      onLongPress: () {
                        _presenter.deleteStore(store.id);
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newStore = Store(
            id: 0,
            name: "toko makmur",
            username: "rizal",
            password: 'password',
          );
          _presenter.addStore(newStore);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void showStores(List<Store> stores) {
    setState(() {
      _isLoading = false;
      _stores = stores;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _isLoading = false;
      _errorMessage = message;
    });
  }
}

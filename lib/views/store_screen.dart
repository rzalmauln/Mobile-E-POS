import 'package:e_pos/cubits/store/cubit_store.dart';
import 'package:e_pos/cubits/store/cubit_store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StoreCubit>().loadStores();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
      ),
      body:
          BlocConsumer<StoreCubit, StoreCubitState>(listener: (context, state) {
        if (state is ErrorCubitState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      }, builder: (_, state) {
        if (state is LoadingCubitState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadedCubitState) {
          var stores = state.store;
          if (stores!.isEmpty) {
            return const Center(child: Text('No Data'));
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: stores.length,
            itemBuilder: (_, index) {
              var storeData = stores[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeData.name,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        storeData.username,
                        // style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        storeData.password,
                        // style: Theme.of(context).textTheme.caption,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              onPressed: () {}, child: Text('DELETE')),
                          OutlinedButton(onPressed: () {}, child: Text('EDIT'))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No Data'));
        }
      }),
    );
  }
}

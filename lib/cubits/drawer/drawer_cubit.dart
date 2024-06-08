import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_pos/cubits/drawer/drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerState(page: 0));

  void setDrawer(int changePage) {
    emit(DrawerState(page: changePage));
  }

  int getDrawer() {
    return state.page;
  }
}

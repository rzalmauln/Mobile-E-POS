import 'package:e_pos/cubits/register/register_state.dart';
import 'package:e_pos/data/model/store/store.dart';
import 'package:e_pos/data/services/store_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  void register(String username, String name, String password) async {
    emit(LoadingRegisterState());
    try {
      Store user = await StoreService().register(username, name, password);
      emit(LoadedRegisterState(user));
    } catch (e) {
      emit(ErrorRegisterState(e.toString()));
    }
  }
}

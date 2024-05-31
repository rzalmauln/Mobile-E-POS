import 'package:e_pos/cubits/login/login_state.dart';
import 'package:e_pos/data/model/store/store.dart';
import 'package:e_pos/data/services/store_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  void login(String username, String password) async {
    try {
      emit(LoadingLoginState());
      Store user = await StoreService().login(username, password);
      print(user);
      emit(LoadedLoginState(user));
    } catch (e) {
      emit(ErrorLoginState(e.toString()));
    }
  }
}

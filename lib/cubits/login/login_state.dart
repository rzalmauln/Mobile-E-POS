import 'package:e_pos/data/model/store/store.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadedLoginState extends LoginState {
  final Store store;
  LoadedLoginState(this.store);
  @override
  List<Object> get props => [store];
}

class ErrorLoginState extends LoginState {
  final String errorMessage;
  ErrorLoginState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

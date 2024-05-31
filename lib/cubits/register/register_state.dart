import 'package:e_pos/data/model/store/store.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {}

class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class LoadingRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

class LoadedRegisterState extends RegisterState {
  final Store user;

  LoadedRegisterState(this.user);
  @override
  List<Object> get props => [user];
}

class ErrorRegisterState extends RegisterState {
  final String errorMessage;
  ErrorRegisterState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

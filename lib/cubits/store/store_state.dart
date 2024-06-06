import 'package:e_pos/data/model/store/store.dart';
import 'package:equatable/equatable.dart';

abstract class StoreCubitState extends Equatable {}

class InitialCubitState extends StoreCubitState {
  @override
  List<Object> get props => [];
}

class LoadingCubitState extends StoreCubitState {
  @override
  List<Object> get props => [];
}

class LoadedCubitState extends StoreCubitState {
  LoadedCubitState(this.store);

  final List<Store>? store;

  @override
  List<Object> get props => [store!];
}

class ErrorCubitState extends StoreCubitState {
  final String errorMessage;
  ErrorCubitState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

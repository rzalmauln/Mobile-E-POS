import 'package:equatable/equatable.dart';

class DrawerState extends Equatable {
  final int page;

  const DrawerState({required this.page});

  @override
  List<Object> get props => [page];
}

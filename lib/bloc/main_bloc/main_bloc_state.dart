import 'package:equatable/equatable.dart';

abstract class MainBlocState extends Equatable {
  const MainBlocState();

  @override
  List<Object> get props => [];
}

class MainBlocInitialState extends MainBlocState {}

class MainBlocLoadedState extends MainBlocState {
  final String query;
  final int selectedMethod;
  const MainBlocLoadedState(
      {required this.query, required this.selectedMethod});
  @override
  List<Object> get props => [query, selectedMethod];
}

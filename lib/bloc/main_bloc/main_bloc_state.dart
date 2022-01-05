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
  final int page;
  const MainBlocLoadedState({
    required this.query,
    required this.selectedMethod,
    required this.page,
  });
  @override
  List<Object> get props => [query, selectedMethod, page];
}

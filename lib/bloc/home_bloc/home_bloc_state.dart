part of 'home_bloc_cubit.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitialState extends HomeBlocState {}

class HomeBlocLoadingState extends HomeBlocState {}

class HomeBlocLoadedState extends HomeBlocState {
  final dynamic data;
  const HomeBlocLoadedState(this.data);
  @override
  List<Object> get props => [data];
}

class HomeBlocErrorState extends HomeBlocState {
  final String error;

  const HomeBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}

import 'package:equatable/equatable.dart';
import 'package:github_app/models/repository.dart';

abstract class RepositoryBlocState extends Equatable {
  const RepositoryBlocState();

  @override
  List<Object?> get props => [];
}

class RepositoryBlocInitialState extends RepositoryBlocState {}

class RepositoryBlocLoadingState extends RepositoryBlocState {}

class RepositoryBlocErrorState extends RepositoryBlocState {
  final String error;
  const RepositoryBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class RepositoryBlocLoadedState extends RepositoryBlocState {
  final List<Repository> repositorys;
  const RepositoryBlocLoadedState(this.repositorys);

  @override
  List<Object?> get props => [repositorys];
}

class RepositoryBlocLazyLoadingState extends RepositoryBlocState {
  final List<Repository> repositorys;
  const RepositoryBlocLazyLoadingState(this.repositorys);

  @override
  List<Object?> get props => [repositorys];
}

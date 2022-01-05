import 'package:equatable/equatable.dart';
import 'package:github_app/models/issue.dart';

abstract class IssueBlocState extends Equatable {
  const IssueBlocState();

  @override
  List<Object?> get props => [];
}

class IssueBlocInitialState extends IssueBlocState {}

class IssueBlocLoadingState extends IssueBlocState {}

class IssueBlocErrorState extends IssueBlocState {
  final String error;
  const IssueBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class IssueBlocLoadedState extends IssueBlocState {
  final List<Issue> issues;
  const IssueBlocLoadedState(this.issues);

  @override
  List<Object?> get props => [issues];
}

class IssueBlocLazyLoadingState extends IssueBlocState {
  final List<Issue> issues;
  const IssueBlocLazyLoadingState(this.issues);

  @override
  List<Object?> get props => [issues];
}

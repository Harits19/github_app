import 'package:equatable/equatable.dart';
import 'package:github_app/models/user.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();

  @override
  List<Object?> get props => [];
}

class UserBlocInitialState extends UserBlocState {}

class UserBlocLoadingState extends UserBlocState {}

class UserBlocErrorState extends UserBlocState {
  final String error;
  const UserBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class UserBlocLoadedState extends UserBlocState {
  final List<User> users;
  const UserBlocLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UserBlocLazyLoadingState extends UserBlocState {
  final List<User> users;
  const UserBlocLazyLoadingState(this.users);

  @override
  List<Object?> get props => [users];
}

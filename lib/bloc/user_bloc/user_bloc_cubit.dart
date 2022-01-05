import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_state.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/services/github_api.dart';

class UserBlocCubit extends Cubit<UserBlocState> {
  UserBlocCubit() : super(UserBlocInitialState());

  final githubApi = GetIt.I<GithubApi>();

  getSearchUser({
    required String query,
    required int page,
  }) async {
    emit(UserBlocLoadingState());
    if (query.isEmpty) emit(const UserBlocLoadedState([]));
    githubApi.getSearchUser(
      page: page,
      query: query,
      onSuccess: (val) {
        emit(UserBlocLoadedState(val));
      },
      onError: (error) {
        emit(UserBlocErrorState(error));
      },
    );
  }

  updatedSearchUser({
    required String query,
    required int page,
  }) {
    final state = this.state;
    if (state is UserBlocLazyLoadingState) return;
    List<User> prevUsers = [];
    if (state is UserBlocLoadedState) {
      prevUsers = state.users;
      emit(UserBlocLazyLoadingState(prevUsers));
    }
    if (query.isEmpty) emit(const UserBlocLoadedState([]));
    githubApi.getSearchUser(
      page: page,
      query: query,
      onSuccess: (val) {
        emit(UserBlocLoadedState([...prevUsers, ...val]));
      },
      onError: (error) {
        emit(UserBlocErrorState(error));
        emit(UserBlocLoadedState(prevUsers));
      },
    );
  }
}

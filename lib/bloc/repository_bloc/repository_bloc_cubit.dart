import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_app/bloc/repository_bloc/repository_bloc_state.dart';
import 'package:github_app/models/repository.dart';
import 'package:github_app/services/github_api.dart';

class RepositoryBlocCubit extends Cubit<RepositoryBlocState> {
  RepositoryBlocCubit() : super(RepositoryBlocInitialState());

  final githubApi = GetIt.I<GithubApi>();

  getSearchRepository({
    required String query,
    required int page,
  }) async {
    if (query.isEmpty) {
      emit(const RepositoryBlocLoadedState([]));
      return;
    }

    emit(RepositoryBlocLoadingState());
    githubApi.getSearchRepository(
      page: page,
      query: query,
      onSuccess: (val) {
        emit(RepositoryBlocLoadedState(val));
      },
      onError: (error) {
        emit(RepositoryBlocErrorState(error));
        emit(const RepositoryBlocLoadedState([]));
      },
    );
  }

  updatedSearchRepository({
    required String query,
    required int page,
  }) {
    final state = this.state;
    if (state is RepositoryBlocLazyLoadingState) return;
    List<Repository> prevRepositorys = [];
    if (state is RepositoryBlocLoadedState) {
      prevRepositorys = state.repositorys;
      emit(RepositoryBlocLazyLoadingState(prevRepositorys));
    }
    if (query.isEmpty) {
      emit(const RepositoryBlocLoadedState([]));
      return;
    }

    githubApi.getSearchRepository(
      page: page,
      query: query,
      onSuccess: (val) {
        emit(RepositoryBlocLoadedState([...prevRepositorys, ...val]));
      },
      onError: (error) {
        emit(RepositoryBlocErrorState(error));
        emit(const RepositoryBlocLoadedState([]));
      },
    );
  }
}

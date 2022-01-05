import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_state.dart';
import 'package:github_app/models/issue.dart';
import 'package:github_app/services/github_api.dart';

class IssueBlocCubit extends Cubit<IssueBlocState> {
  IssueBlocCubit() : super(IssueBlocInitialState());

  final githubApi = GetIt.I<GithubApi>();

  getSearchIssue({
    required String query,
    required int page,
  }) async {
    if (query.isEmpty) {
      emit(const IssueBlocLoadedState([]));
      return;
    }

    emit(IssueBlocLoadingState());
    githubApi.getSearchIssue(
      page: page,
      query: query,
      onSuccess: (val) {
        emit(IssueBlocLoadedState(val));
      },
      onError: (error) {
        emit(IssueBlocErrorState(error));
        emit(const IssueBlocLoadedState([]));
      },
    );
  }

  updatedSearchIssue({
    required String query,
    required int page,
  }) {
    final state = this.state;
    if (state is IssueBlocLazyLoadingState) return;
    List<Issue> prevIssues = [];
    if (state is IssueBlocLoadedState) {
      prevIssues = state.issues;
      emit(IssueBlocLazyLoadingState(prevIssues));
    }
    if (query.isEmpty) {
      emit(const IssueBlocLoadedState([]));
      return;
    }
    githubApi.getSearchIssue(
      page: page,
      query: query,
      onSuccess: (val) {
        emit(IssueBlocLoadedState([...prevIssues, ...val]));
      },
      onError: (error) {
        emit(IssueBlocErrorState(error));
        emit(const IssueBlocLoadedState([]));
      },
    );
  }
}

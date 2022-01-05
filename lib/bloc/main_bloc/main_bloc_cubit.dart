import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';

class MainBlocCubit extends Cubit<MainBlocState> {
  MainBlocCubit()
      : super(const MainBlocLoadedState(
          query: "",
          selectedMethod: 0,
          page: 1,
        ));

  void updateQuery({
    required String query,
  }) async {
    final state = this.state;
    if (state is MainBlocLoadedState) {
      emit(MainBlocLoadedState(
        query: query,
        selectedMethod: state.selectedMethod,
        page: state.page,
      ));
    }
  }

  void updateMethod({
    required int selectedMethod,
  }) async {
    final state = this.state;
    if (state is MainBlocLoadedState) {
      emit(MainBlocLoadedState(
        query: state.query,
        selectedMethod: selectedMethod,
        page: state.page,
      ));
    }
  }

  void updatePage({
    required int page,
  }) async {
    print({updatePage, " called ", page});
    final state = this.state as MainBlocLoadedState;
    emit(MainBlocLoadedState(
      query: state.query,
      selectedMethod: state.selectedMethod,
      page: page,
    ));
  }
}

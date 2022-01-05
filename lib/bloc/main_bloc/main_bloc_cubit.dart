import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';

class MainBlocCubit extends Cubit<MainBlocState> {
  MainBlocCubit()
      : super(const MainBlocLoadedState(
          query: "",
          selectedMethod: 0,
        ));

  void updateQuery({
    required String query,
  }) async {
    final state = this.state;
    if (state is MainBlocLoadedState) {
      emit(MainBlocLoadedState(
        query: query,
        selectedMethod: state.selectedMethod,
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
      ));
    }
  }
}

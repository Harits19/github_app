import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_cubit.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_state.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/ui/extra/image_container.dart';
import 'package:github_app/ui/extra/lazy_loading_view.dart';
import 'package:github_app/utils/helper.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  getData(BuildContext context, int page, {required bool keepPrevius}) {
    final userRead = context.read<UserBlocCubit>();
    final mainState = context.read<MainBlocCubit>().state;
    final runFun =
        keepPrevius ? userRead.updatedSearchUser : userRead.getSearchUser;
    if (mainState is MainBlocLoadedState) {
      runFun(
        query: mainState.query,
        page: page,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBlocCubit, UserBlocState>(
        listener: (context, state) {
          if (state is UserBlocErrorState) {
            Helper.func.showSnackbar(context, state.error);
          }
        },
        child: BlocBuilder<UserBlocCubit, UserBlocState>(
          builder: (context, state) {
            List<User> items = [];
            if (state is UserBlocLoadedState) {
              items = state.users;
            }
            if (state is UserBlocLazyLoadingState) {
              items = state.users;
            }

            return LazyLoadingView(
              onInit: (page) {
                getData(
                  context,
                  page,
                  keepPrevius: false,
                );
                print("called onInit");
              },
              onScrollEnd: (index) {
                getData(
                  context,
                  index,
                  keepPrevius: true,
                );
              },
              isLoading: state is UserBlocLazyLoadingState ||
                  state is UserBlocLoadingState,
              onIndexChange: (page) {
                getData(
                  context,
                  page,
                  keepPrevius: false,
                );
              },
              children: [
                ...(items).map(
                  (e) => ImageContainer(
                    uriImage: e.avatarUrl ?? "",
                    children: [
                      Text(e.login ?? ""),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

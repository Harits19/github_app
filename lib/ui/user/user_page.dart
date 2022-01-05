import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_cubit.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_state.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/ui/extra/image_container.dart';
import 'package:github_app/ui/extra/lazy_loading_view.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  getData(int page, {required bool keepPrevius}) {
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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
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
              onScrollEnd: (index) {
                getData(
                  index,
                  keepPrevius: true,
                );
              },
              isLoading: state is UserBlocLazyLoadingState ||
                  state is UserBlocLoadingState,
              onIndexChange: (page) {
                getData(
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

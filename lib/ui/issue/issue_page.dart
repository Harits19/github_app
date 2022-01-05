import 'package:flutter/material.dart';
import 'package:github_app/ui/extra/image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_cubit.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_state.dart';
import 'package:github_app/models/issue.dart';
import 'package:github_app/ui/extra/lazy_loading_view.dart';
import 'package:github_app/utils/helper.dart';

class IssuePage extends StatelessWidget {
  const IssuePage({Key? key}) : super(key: key);

  getData(BuildContext context, int page, {required bool keepPrevius}) {
    final issueRead = context.read<IssueBlocCubit>();
    final mainState = context.read<MainBlocCubit>().state;
    final runFun =
        keepPrevius ? issueRead.updatedSearchIssue : issueRead.getSearchIssue;
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
      body: BlocListener<IssueBlocCubit, IssueBlocState>(
        listener: (context, state) {
          if (state is IssueBlocErrorState) {
            Helper.func.showSnackbar(context, state.error);
          }
        },
        child: BlocBuilder<IssueBlocCubit, IssueBlocState>(
          builder: (context, state) {
            List<Issue> items = [];
            if (state is IssueBlocLoadedState) {
              items = state.issues;
            }
            if (state is IssueBlocLazyLoadingState) {
              items = state.issues;
            }

            return LazyLoadingView(
              onInit: (index) {
                getData(
                  context,
                  index,
                  keepPrevius: false,
                );
              },
              onScrollEnd: (index) {
                getData(
                  context,
                  index,
                  keepPrevius: true,
                );
              },
              isLoading: state is IssueBlocLazyLoadingState ||
                  state is IssueBlocLoadingState,
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
                    uriImage: e.user?.avatarUrl ?? "",
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title ?? ""),
                            Text(e.updatedAt ?? ""),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Issues",
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              e.state ?? "",
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
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

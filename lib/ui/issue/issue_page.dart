import 'package:flutter/material.dart';
import 'package:github_app/ui/extra/image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_cubit.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_state.dart';
import 'package:github_app/models/issue.dart';
import 'package:github_app/ui/extra/lazy_loading_view.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({Key? key}) : super(key: key);

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  getData(int page, {required bool keepPrevius}) {
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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
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
              onScrollEnd: (index) {
                getData(
                  index,
                  keepPrevius: true,
                );
              },
              isLoading: state is IssueBlocLazyLoadingState ||
                  state is IssueBlocLoadingState,
              onIndexChange: (page) {
                getData(
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

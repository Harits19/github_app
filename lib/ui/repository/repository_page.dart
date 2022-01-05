import 'package:flutter/material.dart';
import 'package:github_app/ui/extra/image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/bloc/repository_bloc/repository_bloc_cubit.dart';
import 'package:github_app/bloc/repository_bloc/repository_bloc_state.dart';
import 'package:github_app/models/repository.dart';
import 'package:github_app/ui/extra/lazy_loading_view.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({Key? key}) : super(key: key);

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  getData(int page, {required bool keepPrevius}) {
    final repositoryRead = context.read<RepositoryBlocCubit>();
    final mainState = context.read<MainBlocCubit>().state;
    final runFun = keepPrevius
        ? repositoryRead.updatedSearchRepository
        : repositoryRead.getSearchRepository;
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
      body: BlocListener<RepositoryBlocCubit, RepositoryBlocState>(
        listener: (context, state) {
          if (state is RepositoryBlocErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<RepositoryBlocCubit, RepositoryBlocState>(
          builder: (context, state) {
            List<Repository> items = [];
            if (state is RepositoryBlocLoadedState) {
              items = state.repositorys;
            }
            if (state is RepositoryBlocLazyLoadingState) {
              items = state.repositorys;
            }

            return LazyLoadingView(
              onScrollEnd: (index) {
                getData(
                  index,
                  keepPrevius: true,
                );
              },
              isLoading: state is RepositoryBlocLazyLoadingState ||
                  state is RepositoryBlocLoadingState,
              onIndexChange: (page) {
                getData(
                  page,
                  keepPrevius: false,
                );
              },
              children: [
                ...(items).map(
                  (e) => ImageContainer(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.name ?? ""),
                            Text(e.createdAt ?? ""),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Total Watcher : ${e.watchersCount}",
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              "Total Star : ${e.stargazersCount}",
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              "Total Fork : ${e.forksCount}",
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

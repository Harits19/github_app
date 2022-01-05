import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/ui/extra/circular_progress.dart';

class LazyLoadingView extends StatefulWidget {
  const LazyLoadingView({
    Key? key,
    required this.onScrollEnd,
    this.isLoading = false,
    this.children = const [],
    required this.onIndexChange,
    this.onInit,
  }) : super(key: key);

  final ValueChanged<int> onScrollEnd;
  final bool isLoading;
  final List<Widget> children;
  final ValueChanged<int> onIndexChange;
  final ValueChanged<int>? onInit;

  @override
  _LazyLoadingViewState createState() => _LazyLoadingViewState();
}

class _LazyLoadingViewState extends State<LazyLoadingView> {
  updatePage() {
    final mainRead = context.read<MainBlocCubit>();
    final mainState = mainRead.state as MainBlocLoadedState;
    mainRead.updatePage(page: (mainState.page + 1));
    widget.onScrollEnd((mainState.page));
  }

  @override
  void initState() {
    super.initState();
    final mainRead = context.read<MainBlocCubit>();
    final mainState = mainRead.state as MainBlocLoadedState;
    if (widget.onInit != null) widget.onInit!((mainState.page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBlocCubit, MainBlocState>(
      listener: (context, state) {
        if (state is MainBlocLoadedState) {
          if (state.selectedMethod == 0) {
            final mainRead = context.read<MainBlocCubit>();
            mainRead.updatePage(page: 1);
          }
        }
      },
      child:
          BlocBuilder<MainBlocCubit, MainBlocState>(builder: (context, state) {
        final _state = state as MainBlocLoadedState;
        final isLazyLoading = _state.selectedMethod == 0;
        return Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    bool isTop = metrics.pixels == 0;
                    if (isTop) {
                      // print('At the top');
                    } else {
                      if (isLazyLoading) updatePage();
                    }
                  }
                  return true;
                },
                child: ListView(
                  children: [
                    ...widget.children,
                    if (widget.isLoading) const CircularProgress(),
                  ],
                ),
              ),
            ),
            if (!isLazyLoading)
              SizedBox(
                height: 40,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      50,
                      (index) => InkWell(
                        onTap: () {
                          final mainRead = context.read<MainBlocCubit>();
                          final mainState =
                              mainRead.state as MainBlocLoadedState;
                          mainRead.updatePage(page: (index + 1));
                          widget.onIndexChange((mainState.page));
                        },
                        child: BlocBuilder<MainBlocCubit, MainBlocState>(
                            builder: (context, bloc) {
                          final state = bloc as MainBlocLoadedState;

                          return Container(
                            color:
                                state.page == (index + 1) ? Colors.grey : null,
                            width: 40,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("${index + 1}")),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )
          ],
        );
      }),
    );
  }
}

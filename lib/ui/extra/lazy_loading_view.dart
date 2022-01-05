import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/ui/extra/circular_progress.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class LazyLoadingView extends StatefulWidget {
  const LazyLoadingView({
    Key? key,
    required this.onScrollEnd,
    this.isLoading = false,
    this.children = const [],
    required this.onIndexChange,
  }) : super(key: key);

  final ValueChanged<int> onScrollEnd;
  final bool isLoading;
  final List<Widget> children;
  final ValueChanged<int> onIndexChange;

  @override
  _LazyLoadingViewState createState() => _LazyLoadingViewState();
}

class _LazyLoadingViewState extends State<LazyLoadingView> {
  int page = 1;

  updatePage() {
    page = page + 1;
    setState(() {});
    widget.onScrollEnd(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocCubit, MainBlocState>(builder: (context, state) {
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
                        page = index + 1;
                        setState(() {});
                        widget.onIndexChange(page);
                      },
                      child: Container(
                        color: page == (index + 1) ? Colors.grey : null,
                        width: 40,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("${index + 1}")),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      );
    });
  }
}

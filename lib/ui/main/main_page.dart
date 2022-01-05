import 'package:flutter/material.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_state.dart';
import 'package:github_app/bloc/repository_bloc/repository_bloc_cubit.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_cubit.dart';
import 'package:github_app/ui/issue/issue_page.dart';
import 'package:github_app/ui/repository/repository_page.dart';
import 'package:github_app/ui/user/user_page.dart';
import 'package:github_app/utils/constans.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedRadio = 0;

  final listBody = const [UserPage(), IssuePage(), RepositoryPage()];

  loadItemUser() {
    final userRead = context.read<UserBlocCubit>();
    final mainState =
        context.read<MainBlocCubit>().state as MainBlocLoadedState;
    userRead.getSearchUser(
      query: mainState.query,
      page: 1,
    );
  }

  loadItemIssue() {
    final issueRead = context.read<IssueBlocCubit>();
    final mainState =
        context.read<MainBlocCubit>().state as MainBlocLoadedState;
    issueRead.getSearchIssue(
      query: mainState.query,
      page: 1,
    );
  }

  loadItemRepo() {
    final issueRead = context.read<RepositoryBlocCubit>();
    final mainState =
        context.read<MainBlocCubit>().state as MainBlocLoadedState;
    issueRead.getSearchRepository(
      query: mainState.query,
      page: 1,
    );
  }

  loadData() {
    if (selectedRadio == 0) {
      loadItemUser();
    } else if (selectedRadio == 1) {
      loadItemIssue();
    } else if (selectedRadio == 2) {
      loadItemRepo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  final mainRead = context.read<MainBlocCubit>();
                  mainRead.updateQuery(query: val);
                  mainRead.updatePage(page: 1);
                  loadData();
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  S.listRadio.length,
                  (index) => InkWell(
                    onTap: () {
                      selectedRadio = index;
                      setState(() {});
                      final mainRead = context.read<MainBlocCubit>();
                      mainRead.updatePage(page: 1);
                    },
                    child: Row(
                      children: [
                        Radio<int>(
                            value: index,
                            groupValue: selectedRadio,
                            onChanged: (index) {
                              if (index == null) return;
                              selectedRadio = index;
                              setState(() {});
                            }),
                        Text(S.listRadio[index]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<MainBlocCubit, MainBlocState>(
              builder: (context, state) {
                return Row(
                  children: [
                    ...List.generate(
                      S.listMethod.length,
                      (index) {
                        late final bool isActive;
                        if (state is MainBlocLoadedState) {
                          isActive = index == state.selectedMethod;
                        }
                        return InkWell(
                          onTap: () {
                            final mainRead = context.read<MainBlocCubit>();
                            mainRead.updateMethod(selectedMethod: index);
                            if (index == 0) {
                              loadData();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isActive ? Colors.grey : null,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              S.listMethod[index],
                              style: TextStyle(
                                color: isActive ? Colors.white : null,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
            Expanded(child: listBody[selectedRadio]),
          ],
        ),
      ),
    );
  }
}

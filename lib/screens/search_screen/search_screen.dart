import 'package:dc_test/model/search_data.dart';
import 'package:dc_test/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:dc_test/screens/search_screen/widgets/empty_widget.dart';
import 'package:dc_test/screens/search_screen/widgets/item_widget.dart';
import 'package:dc_test/screens/search_screen/widgets/search_widget.dart';
import 'package:dc_test/screens/search_screen/widgets/tag_widget.dart';

import 'package:dc_test/styles/dc_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget _getTagWidgets(BuildContext context, String searchingText) {
    List<Widget> widgets = [];
    for (int i = 0; i < tags.length; i++) {
      final element = tags[i];
      widgets.add(TagWidget(
        element,
        selected: searchingText == element,
        index: i,
      ));
    }

    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Gap(25),
                ...widgets,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getListWidget(List<SearchData> list) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 22),
      itemBuilder: (context, index) {
        if (index == list.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 27),
            child: Center(
              child: Text(
                '${list.length} ${list.length == 1 ? 'item' : 'items'}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: DCColor.paragraph,
                ),
              ),
            ),
          );
        }
        return ItemWidget(list[index], index: index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 25,
          endIndent: 25,
          color: index == list.length - 1
              ? Colors.transparent
              : DCColor.background,
        );
      },
      itemCount: list.length + 1,
    );
  }

  Widget _getLoadingWidget() {
    return Column(
      children: const [
        Gap(144),
        SizedBox(
          height: 76,
          width: 76,
          child: LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: [DCColor.primary],
            strokeWidth: 20,
            backgroundColor: Colors.white,
            pathBackgroundColor: DCColor.lightGray,
          ),
        ),
      ],
    );
  }

  final List<String> tags = ['Language', 'Build', 'Design', 'Cloud', 'Test'];
  late SearchScreenCubit cubit;
  late TextEditingController editingController;
  final Duration duration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    final String firstSearch = tags[0];
    cubit = SearchScreenCubit()..searchText(firstSearch);
    editingController = TextEditingController(text: firstSearch);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: DCColor.primary,
        body: Stack(
          children: [
            BlocBuilder<SearchScreenCubit, SearchScreenState>(
              builder: (context, state) {
                return Positioned.fill(
                    child: Container(
                  color: state is DataListFetchFailed
                      ? DCColor.error
                      : DCColor.primary,
                ));
              },
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const Gap(10),
                  SearchWidget(
                    editingController: editingController,
                  ),
                  BlocBuilder<SearchScreenCubit, SearchScreenState>(
                    buildWhen: (previous, current) =>
                        current is FetchingDataList,
                    builder: (context, state) {
                      String searchingText = '';
                      if (state is FetchingDataList) {
                        searchingText = state.text;
                      }
                      return _getTagWidgets(context, searchingText);
                    },
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child:
                            BlocBuilder<SearchScreenCubit, SearchScreenState>(
                          builder: (context, state) {
                            // if (state is FetchingDataList) {
                            //   return _getLoadingWidget();
                            // }
                            // if (state is DataListFetched) {
                            //   if (state.list.isEmpty) {
                            //     return EmptyWidget.empty();
                            //   }
                            //   return _getListWidget(state.list);
                            // }
                            // if (state is DataListFetchFailed) {
                            //   return EmptyWidget.error();
                            // }
                            // return Container();
                            List<SearchData> list = [];

                            if (state is DataListFetched) {
                              list = state.list;
                            }
                            return Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                AnimatedOpacity(
                                  opacity: state is FetchingDataList ? 1 : 0,
                                  duration: duration,
                                  child: _getLoadingWidget(),
                                ),
                                AnimatedOpacity(
                                  opacity:
                                      state is DataListFetched && list.isEmpty
                                          ? 1
                                          : 0,
                                  duration: duration,
                                  child: EmptyWidget.empty(),
                                ),
                                AnimatedOpacity(
                                  opacity: state is DataListFetchFailed ? 1 : 0,
                                  duration: duration,
                                  child: EmptyWidget.error(),
                                ),
                                AnimatedOpacity(
                                  opacity: state is DataListFetched &&
                                          list.isNotEmpty
                                      ? 1
                                      : 0,
                                  duration: duration,
                                  child: _getListWidget(list),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

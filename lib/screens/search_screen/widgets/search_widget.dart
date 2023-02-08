import 'package:dc_test/screens/common_widgets/button.dart';
import 'package:dc_test/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:dc_test/styles/dc_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController editingController;

  const SearchWidget({required this.editingController, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenCubit, SearchScreenState>(
      buildWhen: (previous, current) => current is FetchingDataList,
      builder: (context, state) {
        if (state is FetchingDataList) {
          editingController.text = state.text;
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 57,
          decoration: const BoxDecoration(
            color: DCColor.gray,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Image.asset('assets/icons/search.png'),
              ),
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    final cubit = context.read<SearchScreenCubit>();
                    cubit.searchText(value);
                  },
                  controller: editingController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: DCColor.paragraph,
                      fontSize: 14,
                    ),
                  ),
                  cursorColor: DCColor.paragraph,
                  style: const TextStyle(
                    color: DCColor.title,
                    fontSize: 14,
                  ),
                ),
              ),
              Button(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Image.asset('assets/icons/vector.png'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

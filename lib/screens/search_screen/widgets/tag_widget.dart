import 'package:dc_test/screens/search_screen/cubit/search_screen_cubit.dart';
import 'package:dc_test/screens/search_screen/widgets/dc_animate_widget.dart';
import 'package:dc_test/styles/dc_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagWidget extends StatelessWidget {
  final String text;
  final bool selected;
  final int index;
  const TagWidget(
    this.text, {
    this.selected = false,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = GestureDetector(
      onTap: () {
        context.read<SearchScreenCubit>().searchText(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(right: 10),
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color: selected ? DCColor.primaryDark : DCColor.gray,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? DCColor.gray : DCColor.paragraph,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );

    return DCAnimateWidget.tagItem(index: index, child: child);
  }
}

import 'package:dc_test/styles/dc_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyWidget extends StatelessWidget {
  static const String imagePath = "assets/images/";
  final String image;
  final String title;
  final String remind;
  final String content;
  const EmptyWidget({
    required this.image,
    required this.content,
    required this.remind,
    required this.title,
    super.key,
  });

  factory EmptyWidget.error() {
    return const EmptyWidget(
      image: 'error.png',
      content: 'You may also refresh the page\nor try again later.',
      remind: 'Brace yourself till we get the error fixed.\n',
      title: 'Aaaah!\nSomething went wrong',
    );
  }
  factory EmptyWidget.empty() {
    return const EmptyWidget(
      image: 'empty.png',
      content:
          'Keep calm and search again. We use so\nmany other cool stuff, surely we use\nsomething you like.',
      remind: 'We couldn\'t find what you were looking for\n',
      title: 'Nothing Found',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(82),
        Image.asset('$imagePath$image'),
        const Gap(28),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, color: DCColor.title),
          maxLines: 2,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
                fontSize: 14, color: DCColor.paragraph, height: 1.85),
            children: [
              TextSpan(
                text: remind,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: content,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

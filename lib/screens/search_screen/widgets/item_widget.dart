import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dc_test/model/search_data.dart';
import 'package:dc_test/route/app_router.dart';
import 'package:dc_test/screens/search_screen/widgets/dc_animate_widget.dart';
import 'package:dc_test/styles/dc_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ItemWidget extends StatelessWidget {
  final SearchData searchData;
  final int index;
  const ItemWidget(this.searchData, {required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              AutoRouter.of(context).push(WebviewRoute(url: searchData.url));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: DCColor.gray, width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: searchData.image,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchData.title,
                          style: const TextStyle(
                            color: DCColor.title,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          searchData.description,
                          style: const TextStyle(
                            color: DCColor.paragraph,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Image.asset('assets/icons/right.png'),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return DCAnimateWidget.listItem(
      index: index,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

import '../../../app/locallization/app_localizations.dart';
import '../../../components/expand_image.dart';
import '../../../constants.dart';
import '../../../data/response/images_response.dart';
import 'featured_item_card.dart';

class FeaturedItems extends StatelessWidget {
  final List<ImagesResponse> images;

  const FeaturedItems({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            AppLocalizations.of(context).translate("Images"),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...images.map(
                    (item) => Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: FeaturedItemCard(
                    title: "", // có thể truyền động nếu cần
                    image: item.url!,
                    press: () {
                      showImageDialog(context, item.url!);
                    }, isDetailScreen: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

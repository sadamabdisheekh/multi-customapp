import 'package:flutter/material.dart';
import 'package:multi/constants/images.dart';
import 'package:multi/data/models/items_model.dart';
import 'package:multi/presentation/widgets/custom_images.dart';
import 'package:multi/presentation/widgets/items/item_bottom_sheet.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/styles.dart';
import 'not_available_widet.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.itemsList});

  final ItemsModel itemsList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeExtraSmall),
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: Theme.of(context).cardColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 0))
            ],
          ),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const ItemBottomSheet();
                  });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: Row(children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                          child: CustomImage(
                            path: Kimages.pc,
                            height: 65,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const NotAvailableWidget()
                      ],
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          itemsList.name,
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              'Faaris',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Theme.of(context).disabledColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: Dimensions.fontSizeExtraSmall,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                        Row(children: [
                          Text(
                            '\$${itemsList.price}',
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeSmall),
                            textDirection: TextDirection.ltr,
                          ),
                          const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall),
                          Text(
                            '\$140',
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                              color: Theme.of(context).disabledColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ]),
                      ],
                    ))
                  ]),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
              ],
            ),
          ),
        )
      ],
    );
  }
}

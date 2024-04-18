import 'package:flutter/material.dart';
import 'package:multi/constants/images.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/styles.dart';
import '../custom_images.dart';

class ItemBottomSheet extends StatefulWidget {
  const ItemBottomSheet({super.key});

  @override
  State<ItemBottomSheet> createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 550,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Dimensions.radiusExtraLarge)),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  Flexible(
                      child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault,
                        bottom: Dimensions.paddingSizeDefault),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: Dimensions.paddingSizeDefault,
                            top: Dimensions.paddingSizeDefault,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Product
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall),
                                      child: CustomImage(
                                        path: Kimages.pc,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Baasto',
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Salaam Store',
                                              style: robotoRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              size: Dimensions.fontSizeSmall,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '\$130',
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge),
                                        textDirection: TextDirection.ltr,
                                      ),
                                      Text(
                                        '\$140',
                                        textDirection: TextDirection.ltr,
                                        style: robotoMedium.copyWith(
                                            color:
                                                Theme.of(context).disabledColor,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeLarge),
                              (1 == 1)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('description',
                                            style: robotoMedium),
                                        const SizedBox(
                                            height: Dimensions
                                                .paddingSizeExtraSmall),
                                        Text('this is short description',
                                            style: robotoRegular),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeLarge),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}

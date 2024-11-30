import 'package:flutter/material.dart';
import 'package:multi/constants/images.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/styles.dart';
import '../../../data/models/items_model.dart';
import '../custom_button.dart';
import '../custom_images.dart';
import '../variation.dart';
import 'quantity_button.dart';

class ItemBottomSheet extends StatefulWidget {
  const ItemBottomSheet({super.key, required this.item});

  final ItemsModel item;

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
                                          widget.item.item.name,
                                          style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge),
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
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
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
                                          '\$${widget.item.price}',
                                          style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge),
                                          textDirection: TextDirection.ltr,
                                        ),
                                        Text(
                                          '\$140',
                                          textDirection: TextDirection.ltr,
                                          style: robotoMedium.copyWith(
                                              color: Theme.of(context)
                                                  .disabledColor,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeLarge),
                                (widget.item.item.description != null && widget.item.item.description!.isNotEmpty) ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('description', style: robotoMedium),
                                    const SizedBox(
                                        height:
                                            Dimensions.paddingSizeExtraSmall),
                                    Text(widget.item.item.description ?? '',
                                        style: robotoRegular),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeLarge),
                                  ],
                                ) : const SizedBox(),
                                const NewVariationView(item: [],discount: 0,discountType: null,showOriginalPrice: false,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ),
                  Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const  BorderRadius.all(Radius.circular(0)),
                    boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10)],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                  child: Column(
                    children: [
                         Builder(
                      builder: (context) {
                      //  double? cost = PriceConverter.convertWithDiscount((price! * itemController.quantity!), discount, discountType);
                      //  double withAddonCost = cost! + addonsCost;
                        return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Total Amount', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                          // Row(children: [
                          //   discount! > 0 ? PriceConverter.convertAnimationPrice(
                          //     (price * itemController.quantity!) + addonsCost,
                          //     textStyle: robotoMedium.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall, decoration: TextDecoration.lineThrough),
                          //   ) : const SizedBox(),
                          //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                          //   PriceConverter.convertAnimationPrice(
                          //     withAddonCost,
                          //     textStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
                          //   ),
                          // ]),
                        ]);
                      }
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                     SafeArea(
                      child: Row(children: [
                          // Quantity
                          Row(children: [
                            QuantityButton(
                              onTap: () {
                               
                              },
                              isIncrement: false,
                              fromSheet: true,
                            ),
                            Text('1', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                            QuantityButton(
                              onTap: (){},
                              isIncrement: true,
                              fromSheet: true,
                            ),
                          ]),
                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Expanded(child: CustomButton(buttonText: 'Add to cart')),

                          ]),
                    ),
                 
                    ],
                  ),
                  ),
                    // const SizedBox(height: Dimensions.paddingSizeSmall),
                    
                ],
              )
            ],
          ),
        ));
  }
}

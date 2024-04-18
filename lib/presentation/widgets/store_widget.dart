import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/dimensions.dart';
import '../../constants/images.dart';
import '../../constants/styles.dart';
import 'custom_images.dart';
import 'items/not_available_widet.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              border: Border.all(
                  color: Theme.of(context).disabledColor.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ]),
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.radiusDefault)),
                    child: CustomImage(
                      path: Kimages.pc,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  NotAvailableWidget(
                      fontSize: Dimensions.fontSizeExtraSmall,
                      isAllSideRound: false),
                  Positioned(
                    bottom: -15,
                    left: null,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                      ),
                      child: Row(children: [
                        Icon(Icons.star,
                            size: 15,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall),
                        Text(
                          '5,4',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall),
                        ),
                        const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall),
                        Text(
                          '(1)',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: context.width * 0.7,
                      child: Text(
                        'Salaam Restaurent',
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                
                    Row(children: [
                      Icon(Icons.location_on_outlined, size: 15, color: Theme.of(context).primaryColor),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                
                      Flexible(
                        child: Text(
                          'Mogadisho Somalia',
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                
                    Row(children: [
                     
                
                      Row(children: [
                        Icon(Icons.timer, size: 15, color: Theme.of(context).primaryColor),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                
                        Text(
                          '30-40 min',
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                        ),
                      ]),
                    ]),
                  ]),
                ),
         
            ],
          ),
        )
      ],
    );
  }
}

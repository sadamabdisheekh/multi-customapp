import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';
import '../../constants/styles.dart';

class NewVariationView extends StatelessWidget {
  final List item;
  final double? discount;
  final String? discountType;
  final bool showOriginalPrice;
  const NewVariationView(
      {super.key,
      required this.item,
      required this.discount,
      required this.discountType,
      required this.showOriginalPrice});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
      itemBuilder: (context, index) {
        // int selectedCount = 0;
        // if(item!.foodVariations![index].required!){
        //   for (var value in itemController.selectedVariations[index]) {
        //     if(value == true){
        //       selectedCount++;
        //     }
        //   }
        // }
        return Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
          decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.05),
              border: Border.all(
                  color: Theme.of(context).disabledColor, width: 0.5),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Bariis',
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                    ),
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Text(
                      'required',
                      style: robotoRegular.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                  ),
                ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              'select minimum 1 up 2',
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 4,
              itemBuilder: (context, i) {
                if (i == 4) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: InkWell(
                      onTap: () {},
                      child: Row(children: [
                        Icon(Icons.expand_more,
                            size: 18, color: Theme.of(context).primaryColor),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text('more_option',
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ]),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: InkWell(
                      onTap: () {
                        // itemController.setNewCartVariationIndex(index, i, item!);
                      },
                      child: Row(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              1 == 1
                                  ? Checkbox(
                                      value: true,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall)),
                                      onChanged: (bool? newValue) {
                                        // itemController.setNewCartVariationIndex(index, i, item!);
                                      },
                                      visualDensity: const VisualDensity(
                                          horizontal: -3, vertical: -3),
                                      side: BorderSide(
                                          width: 2,
                                          color: Theme.of(context).hintColor),
                                    )
                                  : Radio(
                                      value: i,
                                      groupValue:
                                          null, //itemController.selectedVariations[index].indexOf(true),
                                      onChanged: (dynamic value) {
                                        // itemController.setNewCartVariationIndex(index, i, item!);
                                      },
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      toggleable: false,
                                      visualDensity: const VisualDensity(
                                          horizontal: -3, vertical: -3),
                                    ),
                              Text(
                                'level',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: robotoMedium,
                              ),
                            ]),
                        const Spacer(),
                        showOriginalPrice
                            ? Text(
                                '+100',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.ltr,
                                style: /* itemController.selectedVariations[index][i]! ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, decoration: TextDecoration.lineThrough)
                              :*/
                                    robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context).disabledColor,
                                        decoration: TextDecoration.lineThrough),
                              )
                            : const SizedBox(),
                        SizedBox(
                            width: showOriginalPrice
                                ? Dimensions.paddingSizeExtraSmall
                                : 0),
                        Text('+22',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall)),
                      ]),
                    ),
                  );
                }
              },
            ),
          ]),
        );
      },
    );
  }
}

class AddonView extends StatelessWidget {
  final List item;
  const AddonView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('addons', style: robotoMedium),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Text(
              'optional',
              style: robotoRegular.copyWith(
                  color: Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeSmall),
            ),
          ),
        ]),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 2,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeExtraSmall),
                child: Row(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Checkbox(
                      value: true,
                      activeColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall)),
                      onChanged: (bool? newValue) {},
                      visualDensity:
                          const VisualDensity(horizontal: -3, vertical: -3),
                      side: BorderSide(
                          width: 2, color: Theme.of(context).hintColor),
                    ),
                    Text(
                      'index $index',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: robotoMedium,
                    ),
                  ]),
                  const Spacer(),
                  Text('free',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall)),
                  Container(
                    height: 25,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context).cardColor),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                  child: Icon(
                                (2 > 1)
                                    ? Icons.remove
                                    : Icons.delete_outline_outlined,
                                size: 18,
                                color: (2 > 1)
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.error,
                              )),
                            ),
                          ),
                          Text(
                            'me',
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                  child: Icon(Icons.add,
                                      size: 18,
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        ]),
                  ),
                ]),
              ),
            );
          },
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/cart/cart_response_model.dart';

import '../../../../logic/utility.dart';
import '../../../widgets/custom_images.dart';

class CheckoutSingleItem extends StatelessWidget {
  const CheckoutSingleItem(
      {super.key, required this.item});

  final CartResponseModel item;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
  const double height = 120;
    return Container(
      margin: Utils.only(bottom: 8.0),
      padding: Utils.symmetric(h: 0.0,v: 5.0),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: Utils.borderRadius(r: 12.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0.0, 0.0),
                spreadRadius: 0.0,
                blurRadius: 0.0,
                // color: whiteColor
                color: const Color(0xFF000000).withOpacity(0.4)),
          ]),
      child: Row(
        children: [
          SizedBox(
            height: height - 2,
            width: width / 2.7,
            child: ClipRRect(
              borderRadius:
              Utils.borderRadius(r: 6.0),
              child: InkWell(
                onTap: () {
                
                },
                child: CustomImage(
                  path: AppConstants.itemsPath + item.storeItem.item.thumbnail!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    item.storeItem.item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price}',
                      style:  TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'x ${item.quantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                // Wrap(
                //   children: product.variants
                //       .map(
                //         (e) => Text(
                //           '${e.varientItem!.productVariantName} : ${e.varientItem!.name ?? ''}, ',
                //           style: const TextStyle(fontSize: 10),
                //         ),
                //       )
                //       .toList(),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

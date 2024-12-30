import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_text.dart';
import 'package:badges/badges.dart' as badges;

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.count});

  final String? count;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -10),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).primaryColor,
      ),
      badgeContent: CustomText(
        text: count?.isNotEmpty ?? false ? count! : '0',
        fontSize: 10,
        color: Theme.of(context).cardColor,
      ),
      child: const Icon(CupertinoIcons.cart),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi/constants/styles.dart';

import '../../../data/static_data.dart';
import '../items/item_bottom_sheet.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({super.key});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              selectedIndex = index;
              setState(() {});
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (con) => const ItemBottomSheet(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Theme.of(context).primaryColor.withOpacity(1)
                        : Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text("${tabs[index]}",
                      textAlign: TextAlign.center,
                      style: robotoMedium.copyWith(
                          color: selectedIndex == index
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).primaryColor)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

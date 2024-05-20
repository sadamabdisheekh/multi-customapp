import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/dimensions.dart';
import 'package:multi/constants/styles.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/models/sub_category.dart';
import 'package:multi/logic/cubit/items_cubit.dart';

class SubCategory2 extends StatefulWidget {
  const SubCategory2(
      {super.key, required this.subCategoryList, required this.category});

  final List<SubCategoryModel> subCategoryList;
  final CategoryModel category;

  @override
  State<SubCategory2> createState() => _SubCategory2State();
}

class _SubCategory2State extends State<SubCategory2> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.subCategoryList.length,
        itemBuilder: (BuildContext context, int index) {
          double width = MediaQuery.of(context).size.width;
          return InkWell(
            onTap: () {
              Map<String, dynamic> body = {
                "categoryId": widget.category.id,
                // "subCategoryId": widget.subCategoryList[index].id
              };
              context.read<ItemsCubit>().getItems(body);
              selectedIndex = index;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Center(
                    child: Text(widget.subCategoryList[index].subCategoryName,
                        textAlign: TextAlign.center, style: robotoMedium),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: Dimensions.paddingSizeExtraSmall,
                    width: width * 0.15,
                    alignment: Alignment.center,
                    color: selectedIndex == index ? Colors.white : null,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

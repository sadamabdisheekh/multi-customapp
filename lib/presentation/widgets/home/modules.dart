import 'package:flutter/material.dart';
import 'package:multi/data/router_names.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/styles.dart';

class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    super.key,
    required this.products,
  });

  final List products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 30),
      gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisExtent: 128,
        crossAxisSpacing: 19,
        mainAxisSpacing: 19,
      ),
      itemCount: 7,
      itemBuilder: (BuildContext ctx, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.categoryScreen,arguments: products[index]);
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppConstants.lightGrey),
                    child: Image.asset(
                      "${products[index]['pImage']}",
                      height: 26.82,
                      width: 43.54,
                    )),
                const SizedBox(
                  height: 7,
                ),
                Text("${products[index]['name']}",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: robotoMedium),
              ],
            ),
        );
      },
    );
  }
}

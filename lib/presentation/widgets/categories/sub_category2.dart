import 'package:flutter/material.dart';
import 'package:multi/constants/dimensions.dart';
import 'package:multi/constants/styles.dart';
import '../../../data/static_data.dart';

class SubCategory2 extends StatefulWidget {
  const SubCategory2({super.key});

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
        physics: const NeverScrollableScrollPhysics() ,
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (BuildContext context, int index) {
          double width = MediaQuery.of(context).size.width;
          return InkWell(
            onTap: () {
              selectedIndex = index;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Center(
                    child: Text("${tabs[index]}",
                        textAlign: TextAlign.center,
                        style: robotoMedium),
                  ),
                  const SizedBox(height: 10,),
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

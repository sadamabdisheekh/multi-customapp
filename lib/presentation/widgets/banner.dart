import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';
import '../../constants/styles.dart';

class BannerView extends StatefulWidget {
  final bool isFeatured;
  const BannerView({super.key, required this.isFeatured});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  List bannerList = [1, 2, 3, 4, 5];
  int currentIndex = 0;
  updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.45,
              autoPlay: true,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: 0.95,
              autoPlayInterval: const Duration(seconds: 7),
              onPageChanged: (index, reason) => updateIndex(index)),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'text $i',
                      style: const TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerList.map((bnr) {
            int index = bannerList.indexOf(bnr);
            int totalBanner = bannerList.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: index == currentIndex
                  ? Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      child: Text('${(index) + 1}/$totalBanner',
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: 12)),
                    )
                  : Container(
                      height: 5,
                      width: 6,
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault)),
                    ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

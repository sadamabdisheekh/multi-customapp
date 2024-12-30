import 'package:flutter/material.dart';
import 'package:multi/presentation/widgets/capitalized_word.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/language_string.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return SizedBox(
      // height: Platform.isAndroid ?  80 : 100,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).cardColor,
              selectedLabelStyle:
                  const TextStyle(fontSize: 14, color: blackColor),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: grayColor),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: Language.home.capitalizeByWord(),
                ),
                BottomNavigationBarItem(
                  tooltip: Language.profile.capitalizeByWord(),
                  icon: Icon(Icons.person),
                  label: Language.profile.capitalizeByWord(),
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }
}

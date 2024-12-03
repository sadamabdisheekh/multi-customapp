import 'package:flutter/material.dart';
import 'package:multi/presentation/screens/home.dart';
import 'package:multi/presentation/screens/profile/profile.dart';

import 'component/bottom_navigation_bar.dart';
import 'main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _homeController = MainController();
  late List<Widget> pageList;
  @override
  void initState() {
    pageList = [
      const HomeScreen(),
      const ProfileScreen()
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBody: true,
       body: StreamBuilder<int>(
          initialData: 0,
          stream: _homeController.naveListener.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            int index = snapshot.data ?? 0;
            if (index == 1) {
              // context.read<OrderCubit>().changeCurrentIndex(0);
            }
            return pageList[index];
          },
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
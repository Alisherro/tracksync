import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smerse/constants.dart';
import 'package:smerse/presentation/widgets/app_bar_widget.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  ScaffoldWithBottomNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<String> tabsAssets = [
    runningMapIcon,
    heartIcon,
    starIcon,
    teamIcon,
  ];

  static const double iconSize = 25;
  static const double backgroundIconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: AppBarWidget(
          onProfileTap: () {
            navigationShell.goBranch(4,
                initialLocation: 4 == navigationShell.currentIndex);
          },
        ),
      ),
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  _onTap(index);
                },
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: navigationShell.currentIndex == index
                      ? Stack(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                selectedTab,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: SvgPicture.asset(
                                  tabsAssets[index],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              tabsAssets[index],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

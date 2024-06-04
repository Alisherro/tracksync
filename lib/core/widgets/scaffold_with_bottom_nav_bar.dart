import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/core/widgets/app_bar_widget.dart';

import '../../core/resources/images.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  ScaffoldWithBottomNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<String> tabsAssets = [
    Images.navigation,
    Images.cardiology,
    Images.chart,
    Images.crown,
  ];

  static const double iconSize = 25;
  static const double backgroundIconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:navigationShell.currentIndex!=4? AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: AppBarWidget(
          onProfileTap: () {
            navigationShell.goBranch(4,
                initialLocation: 4 == navigationShell.currentIndex);
          },
        ),
      ):null,
      extendBody: false,
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
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
                  child: Center(
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

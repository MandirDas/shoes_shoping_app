import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/mainscreen_provide.dart';

import 'bottom_nav_widget.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context,mainscreenNotifier,child) {
          return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BottomNavWidget(
                        onTap: () {
                          mainscreenNotifier.pageIndex = 0;
                        },
                        icon: mainscreenNotifier.pageIndex == 0
                            ? Ionicons.home
                            :Icons.home_outlined,
                      ),
                      BottomNavWidget(
                        onTap: () {
                          mainscreenNotifier.pageIndex = 1;

                        },
                        icon: mainscreenNotifier.pageIndex == 1
                            ? Icons.search
                            :Icons.search,
                      ),
                      BottomNavWidget(
                        onTap: () {
                          mainscreenNotifier.pageIndex = 2;
                        },
                        icon: mainscreenNotifier.pageIndex == 2
                            ? Ionicons.add
                            :Ionicons.add_circle_outline,
                      ),
                      BottomNavWidget(
                        onTap: () {
                          mainscreenNotifier.pageIndex = 3;
                        },
                        icon: mainscreenNotifier.pageIndex == 3
                            ? Ionicons.cart
                            :Ionicons.cart_outline,
                      ),
                      BottomNavWidget(
                        onTap: () {
                          mainscreenNotifier.pageIndex = 4;
                        },
                        icon: mainscreenNotifier.pageIndex == 4
                            ? Ionicons.person
                            :Ionicons.person_outline,
                      ),
                    ],
                  ),
                ),
              ),
            );

        });
  }
}

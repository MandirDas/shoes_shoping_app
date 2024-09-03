import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/mainscreen_provide.dart';
import 'package:shoes/views/ui/cartpage.dart';
import 'package:shoes/views/ui/favorites.dart';
import 'package:shoes/views/ui/homepage.dart';
import 'package:shoes/views/ui/profile.dart';
import 'package:shoes/views/ui/searchpage.dart';
import '../shared/bottom_Nav.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favorites(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainscreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainscreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}

import 'package:first_flutter_app/view_models/HomeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MainCategoryEditor.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar();

  @override
  HomeTabBarState createState() => HomeTabBarState();
}

class HomeTabBarState extends State<HomeTabBar> {
  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onLongPress() {
      Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, Animation<double> animation, ___) {
            return FadeTransition(
                opacity: animation, child: MainCategoryEditor());
          },
        ),
      );
    }

    return Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
      final vm = Provider.of<HomeViewModel>(context);

      final Widget tabBar = TabBar(
          onTap: onTap,
          isScrollable: true,
          tabs: vm.state.entries
              .map((e) => Tab(
                  child: Text(e.value.title,
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.bodyText1!.color))))
              .toList());

      return (GestureDetector(onLongPress: onLongPress, child: tabBar));
    });
  }
}

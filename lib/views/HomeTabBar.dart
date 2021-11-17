import 'package:first_flutter_app/view_models/HomeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar();

  @override
  HomeTabBarState createState() => HomeTabBarState();
}

class HomeTabBarState extends State<HomeTabBar> {
  int _currentIndex = 0;
  bool _isEditing = false;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onLongPress() {
    print(this._currentIndex);
    setState(() {
      _isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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

      final Widget textField = TextFormField(
        style: TextStyle(
            fontSize: 24, color: Theme.of(context).textTheme.bodyText1!.color),
        decoration: InputDecoration(border: InputBorder.none),
      );

      final Widget body = this._isEditing ? textField : tabBar;

      return (GestureDetector(onLongPress: onLongPress, child: body));
    });
  }
}

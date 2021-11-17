import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;

import 'HomeTabBar.dart';
import 'MainCategorySection.dart';
import '../view_models/HomeViewModel.dart';
import 'NewRecord.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    void onMainCategoryAddButtonPressed() {
      print('main category add');
    }

    void onPressed() {
      final vm = Provider.of<HomeViewModel>(context, listen: false);
      final mainCategoryId = vm.state.entries.toList()[vm.currentIndex].key;
      final subCategoryId = null;
      print('+');
      Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, Animation<double> animation, ___) {
            return FadeTransition(
              opacity: animation,
              child: NewRecord(
                  mainCategoryId: mainCategoryId, subCategoryId: subCategoryId),
            );
          },
        ),
      );
    }

    return Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
      final vm = Provider.of<HomeViewModel>(context);

      if (vm.isLoading) {
        return Text("Loading...");
      }

      final sections = vm.state.entries
          .map((e) => MainCategorySection(e.key.toString(), e.value))
          .toList();

      return Scaffold(
          body: DefaultTabController(
              length: sections.length,
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    final TabController? controller =
                        DefaultTabController.of(context);
                    controller?.addListener(() {
                      if (!controller.indexIsChanging)
                        vm.setCurrentIndex(controller.index);
                    });
                    return <Widget>[
                      SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: SliverAppBar(
                              title: Text(
                                title,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .overline
                                      ?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              pinned: true,
                              snap: false,
                              floating: true,
                              backgroundColor: Theme.of(context).canvasColor,
                              foregroundColor: Theme.of(context).canvasColor,
                              forceElevated: innerBoxIsScrolled,
                              bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(50),
                                  child: (Row(children: [
                                    Expanded(
                                        child: Container(child: HomeTabBar())),
                                    Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).canvasColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .canvasColor
                                                      .withOpacity(0.9),
                                                  offset: Offset(-4, 0),
                                                  spreadRadius: 7,
                                                  blurRadius: 7)
                                            ]),
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(0),
                                        child: TextButton(
                                            onPressed:
                                                onMainCategoryAddButtonPressed,
                                            child: Text('+',
                                                style:
                                                    TextStyle(fontSize: 24))))
                                  ]))))),
                    ];
                  },
                  body: TabBarView(children: sections))),
          floatingActionButton: Container(
              child: FloatingActionButton(
                  heroTag: vm.state.entries
                          .toList()[vm.currentIndex]
                          .key
                          .toString() +
                      'NewRecord',
                  child: Icon(Icons.add),
                  onPressed: onPressed)));
    });
  }
}

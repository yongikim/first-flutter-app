import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;

import 'MainCategorySection.dart';
import '../view_models/HomeViewModel.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        final vm = Provider.of<HomeViewModel>(context);

        if (vm.isLoading) {
          return Text("Loading...");
        }

        final sections = vm.state.entries
            .map((e) => MainCategorySection(e.key.toString(), e.value))
            .toList();

        return DefaultTabController(
            length: sections.length,
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                            title: Text(
                              title,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.overline?.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            pinned: false,
                            snap: false,
                            floating: false,
                            backgroundColor: Theme.of(context).canvasColor,
                            foregroundColor: Theme.of(context).canvasColor,
                            forceElevated: innerBoxIsScrolled,
                            bottom: TabBar(
                                isScrollable: true,
                                tabs: vm.state.entries
                                    .map((e) => Tab(
                                        child: Text(e.value.title,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color))))
                                    .toList())))
                  ];
                },
                body: TabBarView(children: sections)));
      },
    );
  }
}

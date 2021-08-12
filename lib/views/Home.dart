import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, Provider;

import 'MainAppBar.dart';
import 'MainCategorySection.dart';
import '../view_models/HomeViewModel.dart';

class Home extends StatelessWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  void _incrementCounter() async {
    print('+');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        final vm = Provider.of<HomeViewModel>(context);

        if (vm.isLoading) {
          return Text("Loading...");
        }

        final sections = vm.state.entries
            .map((e) => MainCategorySection(e.key.toString(), e.value));
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                MainAppBar(title: 'Main App Bar'),
                sections.first,
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

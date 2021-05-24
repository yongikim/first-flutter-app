import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MainAppBar.dart';
import 'MainCategorySection.dart';
import 'RootState.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RootState>(
      builder: (context, rootState, child) {
        var cardStates = rootState.cardStates;
        var sections = [];
        cardStates.forEach((key, value) {
          sections.add(MainCategorySection(key, value));
        });

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                MainAppBar(title: 'Main App Bar'),
                ...sections,
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

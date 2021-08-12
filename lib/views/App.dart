import 'package:flutter/material.dart';

import 'Home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid List',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Home(
        title: 'Grid List',
      ),
    );
  }
}

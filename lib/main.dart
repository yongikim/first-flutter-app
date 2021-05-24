import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';
import 'RootState.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RootState(),
      child: App(),
    ),
  );
}

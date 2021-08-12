import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/App.dart';
import 'view_models/HomeViewModel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return HomeViewModel();
      },
      child: App(),
    ),
  );
}

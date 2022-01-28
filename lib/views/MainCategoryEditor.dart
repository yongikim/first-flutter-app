import 'package:first_flutter_app/view_models/HomeViewModel.dart';
import 'package:first_flutter_app/views/MainCategoryEditorItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
      final vm = Provider.of<HomeViewModel>(context);
      final List<int> mainCategories = vm.state.keys.toList();

      Widget itemBuilder(BuildContext bctx, int index) {
        return MainCategoryEditorItem(
            key: ValueKey(index),
            index: index,
            mainCategoryId: mainCategories.elementAt(index));
      }

      void onReorder(int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          // removing the item at oldIndex will shorten the list by 1.
          newIndex -= 1;
        }
        final int id = mainCategories.removeAt(oldIndex);
        mainCategories.insert(newIndex, id);
      }

      return Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text("Edit main categories"),
          pinned: true,
          snap: false,
          floating: true,
        ),
        SliverReorderableList(
            itemBuilder: itemBuilder,
            itemCount: mainCategories.length,
            onReorder: onReorder)
      ]));

      // return Scaffold(
      //     body: Column(children: mainCategories.map((c) => Text(c)).toList()));
    });
  }
}

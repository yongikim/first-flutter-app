import 'package:first_flutter_app/models/MainCategory.dart';
import 'package:first_flutter_app/view_models/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryEditorItem extends StatelessWidget {
  const MainCategoryEditorItem(
      {Key? key, required this.index, required this.mainCategoryId})
      : super(key: key);

  final int index;
  final int mainCategoryId;

  @override
  Widget build(BuildContext context) {
    return ReorderableDelayedDragStartListener(
        index: index,
        key: ValueKey(index),
        child: FutureBuilder(
            future: Provider.of<HomeViewModel>(context)
                .getMainCategory(mainCategoryId),
            builder: (context, AsyncSnapshot<MainCategory> snapshot) {
              if (snapshot.hasData) {
                final MainCategory mainCategory = snapshot.data!;
                return Padding(
                    child: Row(children: [
                      Expanded(child: Text(mainCategory.name)),
                      Icon(Icons.drag_handle),
                    ]),
                    padding: EdgeInsets.all(16));
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            }));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_models/CardState.dart';

class Detail extends StatelessWidget {
  final CardState cardState;

  Detail(this.cardState);

  @override
  Widget build(BuildContext context) {
    final String heroTag = this.cardState.category.id.toString() +
        this.cardState.label.id.toString();
    final String cardName = this.cardState.label.name;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    void onHorizontalDragDown(DragDownDetails _) {
      Navigator.of(context).pop();
    }

    return Scaffold(
      // backgroundColor: Colors.transparent,
      backgroundColor: Theme.of(context).canvasColor,
      body: Hero(
        tag: heroTag,
        child: Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            onHorizontalDragDown: onHorizontalDragDown,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).cardColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: statusBarHeight,
                  ),
                  Text(
                    cardName,
                    style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  Container(
                    child: Text('content'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

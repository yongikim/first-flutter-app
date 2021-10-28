import 'package:first_flutter_app/view_models/HomeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/CardState.dart';
import 'Detail.dart';
import 'Record.dart';

// ignore: must_be_immutable
class MainCategorySectionCard extends StatefulWidget {
  final String title;
  final int index;
  CardState cardState;

  MainCategorySectionCard(this.title, this.cardState, this.index);

  @override
  MainCategorySectionCardState createState() => MainCategorySectionCardState();
}

class MainCategorySectionCardState extends State<MainCategorySectionCard> {
  bool _hasPadding = false;
  Map<String, double> _tapDownPosition = {'x': 0, 'y': 0};

  void onTap() {
    setState(() {
      _hasPadding = false;
    });

    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (_, Animation<double> animation, ___) {
          return FadeTransition(
            opacity: animation,
            child: Record(widget.cardState.mainCategory.id,
                widget.cardState.subCategory.id, widget.cardState),
          );
        },
      ),
    );
  }

  void onTapDown(TapDownDetails tapDownDetails) {
    setState(() {
      _hasPadding = true;
      _tapDownPosition = {
        'x': tapDownDetails.localPosition.dx,
        'y': tapDownDetails.globalPosition.dy
      };
    });
  }

  void onLongPressEnd(LongPressEndDetails _) {
    setState(() {
      _hasPadding = false;
    });
  }

  void onTapCancel() {
    setState(() {
      _hasPadding = false;
    });
  }

  void onLongPress() {
    double left = _tapDownPosition['x'] ?? 0;
    double top = _tapDownPosition['y'] ?? 0;
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, left, top),
        items: [
          PopupMenuItem(child: Text("Item1")),
          PopupMenuItem(child: Text("Item2"))
        ]);
  }

  void onDetailButtonTap() {
    Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (_, Animation<double> animation, ___) {
            return FadeTransition(
              opacity: animation,
              child: Detail(widget.cardState),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String cardName = widget.cardState.label.name;
    final String heroTag = widget.cardState.mainCategory.id.toString() +
        widget.cardState.label.id.toString();
    double todayTotal = widget.cardState.todayTotal;
    double thisMonthTotal = widget.cardState.thisMonthTotal;
    double lastMonthTotal = widget.cardState.lastMonthTotal;

    return Hero(
      tag: heroTag,
      child: Material(
        type: MaterialType.transparency,
        child: AnimatedPadding(
          duration: const Duration(
            milliseconds: 120,
          ),
          padding: EdgeInsets.all(_hasPadding ? 4 : 0),
          child: GestureDetector(
            onTapDown: onTapDown,
            onLongPressEnd: onLongPressEnd,
            onTap: onTap,
            onTapCancel: onTapCancel,
            onLongPress: onLongPress,
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsetsDirectional.only(
                start: widget.index % 2 == 0 ? 16 : 6,
                end: widget.index % 2 == 0 ? 6 : 16,
                bottom: 6,
                top: 6,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cardName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color)),
                    // TextField(
                    //   enabled: false,
                    //   onSubmitted: onLabelNameSubmitted,
                    //   decoration: InputDecoration(
                    //       hintStyle: TextStyle(
                    //           height: 0.5,
                    //           fontSize: 16,
                    //           color:
                    //               Theme.of(context).textTheme.bodyText1!.color),
                    //       hintText: cardName,
                    //       border: InputBorder.none),
                    // ),
                    Spacer(),
                    Spacer(),
                    Center(
                        child: Text(thisMonthTotal.toString(),
                            style: TextStyle(
                              fontSize: 36,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ))),
                    Spacer(),
                    Center(
                      child: MaterialButton(
                        child: Text('Detail'),
                        onPressed: onDetailButtonTap,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

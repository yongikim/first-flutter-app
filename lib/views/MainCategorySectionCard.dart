import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  var _hasPadding = false;

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
            child: Record(widget.cardState.category.id, widget.cardState),
          );
        },
      ),
    );
  }

  void onTapDown(TapDownDetails _) {
    setState(() {
      _hasPadding = true;
    });
  }

  void onTapCancel() {
    setState(() {
      _hasPadding = false;
    });
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
    final String heroTag = widget.cardState.category.id.toString() +
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
            onTap: onTap,
            onTapCancel: onTapCancel,
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
                    Text(
                      cardName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'This month $thisMonthTotal',
                      style: TextStyle(
                        color: Theme.of(context).cardTheme.color,
                      ),
                    ),
                    Text(
                      'Last month $lastMonthTotal',
                      style: TextStyle(
                        color: Theme.of(context).cardTheme.color,
                      ),
                    ),
                    Text(
                      'Today $todayTotal',
                      style: TextStyle(
                        color: Theme.of(context).cardTheme.color,
                      ),
                    ),
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

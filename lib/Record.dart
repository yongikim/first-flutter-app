import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'CardState.dart';
import 'RootState.dart';

class Record extends StatelessWidget {
  final String mainCategoryId;
  final CardState cardState;

  Record(this.mainCategoryId, this.cardState);

  @override
  Widget build(BuildContext context) {
    final String heroTag = this.mainCategoryId + this.cardState.subCategory.id;
    final String cardName = this.cardState.subCategory.name;
    final double todayTotal = this.cardState.todayTotal;
    final double thisMonthTotal = this.cardState.thisMonthTotal;
    final double lastMonthTotal = this.cardState.lastMonthTotal;

    double _ = MediaQuery.of(context).padding.top;

    void onVerticalDragEnd(DragEndDetails _) {
      Navigator.of(context).pop();
    }

    return Consumer<RootState>(builder: (context, rootState, child) {
      void onFieldSubmitted(String value) {
        var addValue = double.tryParse(value) ?? 0;

        rootState.add(
            this.mainCategoryId, this.cardState.subCategory.id, addValue);
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
              onVerticalDragEnd: onVerticalDragEnd,
              child: Container(
                padding: EdgeInsetsDirectional.only(
                  top: 64,
                  start: 16,
                  end: 16,
                ),
                color: Theme.of(context).canvasColor,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            cardName,
                            style: TextStyle(
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 32,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.end,
                            textAlignVertical: TextAlignVertical.bottom,
                            autofocus: true,
                            onFieldSubmitted: onFieldSubmitted,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              )),
                              hintText: 'Input number: ',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

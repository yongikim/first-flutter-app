import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../view_models/HomeViewModel.dart';

class NewRecord extends StatefulWidget {
  final int mainCategoryId;
  final int? subCategoryId;

  NewRecord({required this.mainCategoryId, this.subCategoryId});

  @override
  _NewRecordState createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  String _newLabelName = 'New Label';
  bool _isTransitionComplete = false;

  void _completeTransition() {
    setState(() {
      _isTransitionComplete = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _completeTransition());
  }

  @override
  Widget build(BuildContext context) {
    final String heroTag = widget.mainCategoryId.toString() + 'NewRecord';
    final double todayTotal = 0;
    final double thisMonthTotal = 0;
    final double lastMonthTotal = 0;

    double _ = MediaQuery.of(context).padding.top;

    void onVerticalDragEnd(DragEndDetails _) {
      Navigator.of(context).pop();
    }

    void onChanged(String text) {
      _newLabelName = text;
    }

    void onFieldSubmitted(String value) async {
      var addValue = double.tryParse(value) ?? 0;
      await Provider.of<HomeViewModel>(context, listen: false)
          .create(widget.mainCategoryId, widget.subCategoryId, _newLabelName, addValue);

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
                        TextField(
                          decoration: InputDecoration(hintText: 'Label Name'),
                          onChanged: onChanged,
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
                        TextFormField(
                          style: TextStyle(
                            fontSize: 32,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          textAlignVertical: TextAlignVertical.bottom,
                          autofocus: _isTransitionComplete,
                          onFieldSubmitted: onFieldSubmitted,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                            )),
                            hintText: 'Input number: ',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
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
  }
}

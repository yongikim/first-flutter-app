import 'package:flutter/material.dart';

class EditableTitle extends StatelessWidget {
  final String? initialValue;
  EditableTitle({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(border: InputBorder.none),
        style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color));
  }
}

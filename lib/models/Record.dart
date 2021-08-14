import 'package:first_flutter_app/view_models/Category.dart';
import 'package:first_flutter_app/view_models/Label.dart';

class Record {
  final int id;
  final double amount;
  final int month;
  final int day;
  final Category category;
  final Label label;

  Record(this.id, this.amount, this.month, this.day, this.category, this.label);

  Map<String, Object> toMap() {
    return {
      'id': id,
      'amount': amount,
      'month': month,
      'day': day,
      'category_id': category.id,
      'label_id': label.id,
    };
  }
}

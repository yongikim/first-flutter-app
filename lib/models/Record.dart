import 'package:first_flutter_app/models/MainCategory.dart';
import 'package:first_flutter_app/models/SubCategory.dart';
import 'package:first_flutter_app/models/Label.dart';

class Record {
  final int id;
  final double amount;
  final int month;
  final int day;
  final MainCategory mainCategory;
  final SubCategory subCategory;
  final Label label;

  Record(this.id, this.amount, this.month, this.day, this.mainCategory,
      this.subCategory, this.label);

  Map<String, Object> toMap() {
    return {
      'id': id,
      'amount': amount,
      'month': month,
      'day': day,
      'main_category_id': mainCategory.id,
      'sub_category_id': subCategory.id,
      'label_id': label.id,
    };
  }
}

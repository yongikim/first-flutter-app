import '../models/MainCategory.dart';
import '../models/SubCategory.dart';
import '../models/Label.dart';

class CardState {
  MainCategory mainCategory;
  SubCategory subCategory;
  Label label;
  double todayTotal;
  double thisMonthTotal;
  double lastMonthTotal;

  CardState(this.mainCategory, this.subCategory, this.label, this.todayTotal, this.thisMonthTotal,
      this.lastMonthTotal);

  Map<String, Object?> toMap() {
    return {
      'main_category_Id': mainCategory.id,
      'sub_category_Id': subCategory.id,
      'label_id': label.id,
      'todayTotal': todayTotal,
      'thisMonthTotal': thisMonthTotal,
      'lastMonthTotal': lastMonthTotal
    };
  }
}

import 'Category.dart';
import 'Label.dart';

class CardState {
  Category category;
  Label label;
  double todayTotal;
  double thisMonthTotal;
  double lastMonthTotal;

  CardState(this.category, this.label, this.todayTotal, this.thisMonthTotal,
      this.lastMonthTotal);
}

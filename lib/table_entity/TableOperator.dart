import 'package:stock_flutter_app/entity/Operator.dart';

class TableOperator {
  bool checked;
  Operator operator;

  TableOperator(this.checked, this.operator);

  TableOperator fromOperator (Operator operator){
    return TableOperator(false, operator);
  }

  @override
  String toString() {
    return 'TableDriver{checked: $checked, operator: $operator}';
  }
}
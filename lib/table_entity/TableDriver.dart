import 'package:stock_flutter_app/entity/Driver.dart';

class TableDriver {
  bool checked;
  Driver driver;

  TableDriver(this.checked, this.driver);

  TableDriver fromDriver (Driver driver){
    return TableDriver(false, driver);
  }

  @override
  String toString() {
    return 'TableDriver{checked: $checked, driver: $driver}';
  }
}
import 'package:stock_flutter_app/entity/Driver.dart';
import 'package:stock_flutter_app/entity/Operator.dart';

class Waybill{

  int id;
  String dateOfDelivery;
  String dateOfShipment;
  Driver driver;
  Operator operator;

  Waybill(this.id, this.dateOfDelivery, this.dateOfShipment, this.driver,
      this.operator);
}
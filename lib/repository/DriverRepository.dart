import 'dart:convert';

import 'package:http/http.dart';
import 'package:stock_flutter_app/entity/Driver.dart';
import 'package:stock_flutter_app/network/Networker.dart';

class DriverRepository {
  Future<List<Driver>> selectAll() async {
    Response response = await Networker.instance.getAllDrivers();
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Driver> list = items.map<Driver>((json){
      return Driver.fromJson(json);
    }).toList();
    print(list);
  }
}
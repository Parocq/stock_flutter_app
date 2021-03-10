import 'dart:convert';
import 'package:http/http.dart';

class Networker {
  String baseUrl = 'http://192.168.1.6:8080';
  final headers = {'Content-Type': 'application/json'};

  Networker._privateConstructor();

  static final Networker _instance = Networker._privateConstructor();

  static Networker get instance => _instance;

  /**----------------------------- ACCOUNT -----------------------------**/
  Future<Response> loginRequest(String body) async {
    print('baseUrl:${baseUrl}');
    Response response = await post(baseUrl + "/login",
        headers: headers, body: body, encoding: Encoding.getByName("utf-8"));

    return response;
  }

  Future<Response> registrationRequest(String body) async {
    Response response = await post(baseUrl + "/create",
        headers: headers, body: body, encoding: Encoding.getByName("utf-8"));

    return response;
  }

  /**----------------------------- DRIVERS -----------------------------**/
  Future<Response> getAllDrivers() async {
    Response response = await get(baseUrl + "/driver/selectAll");
    return response;
  }

  Future<bool> insertDriver(String driver) async {
    Response response = await post(baseUrl + "/driver/create",
        headers: headers, body: driver, encoding: Encoding.getByName("utf-8"));

    if (response.statusCode != 200) return false;
    return true;
  }

  Future<bool> updateDriver(String driver) async {
    Response response = await post(baseUrl + "/driver/update",
        headers: headers, body: driver, encoding: Encoding.getByName("utf-8"));

    if (response.statusCode != 200) return false;
    return true;
  }

  Future<bool> removeDrivers(List<int> list) async {
    if (list.isEmpty) return false;

    print(list.toString());
    Response response =
        await post(baseUrl + "/driver/deleteFew",body: list.toString(), headers: headers);
    if (response.statusCode != 200) return false;

    return true;
  }

/**----------------------------- OPERATORS -----------------------------**/

  Future<Response> getAllOperators() async {
    print('baseUrl + \"/operator/all\"');
    Response response = await get(baseUrl + "/operator/selectAll");
    return response;
  }

  Future<bool> insertOperator(String operator) async {
    Response response = await post(baseUrl + "/operator/create",
        headers: headers, body: operator, encoding: Encoding.getByName("utf-8"));

    if (response.statusCode != 200) return false;
    return true;
  }

  Future<bool> updateOperator(String operator) async {
    Response response = await post(baseUrl + "/operator/update",
        headers: headers, body: operator, encoding: Encoding.getByName("utf-8"));

    if (response.statusCode != 200) return false;
    return true;
  }

  Future<bool> removeOperators(List<int> list) async {
    if (list.isEmpty) return false;

    print(list.toString());
    Response response =
    await post(baseUrl + "/operator/deleteFew",body: list.toString(), headers: headers);
    if (response.statusCode != 200) return false;

    return true;
  }
}

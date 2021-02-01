import 'dart:convert';
import 'package:http/http.dart';


class Networker {

  final baseUrl = 'http://192.168.1.5:8080';
  final headers = {'Content-Type': 'application/json'};

  Networker._privateConstructor();

  static final Networker _instance = Networker._privateConstructor();

  static Networker get instance => _instance;


  Future<Response> loginRequest(String body) async {
    Response response = await post(baseUrl+"/login",
        headers: headers, body: body, encoding: Encoding.getByName("utf-8"));

    return response;
  }

  Future<Response> registrationRequest(String body) async {
    Response response = await post(baseUrl+"/create",
        headers: headers, body: body, encoding: Encoding.getByName("utf-8"));

    return response;
  }
}
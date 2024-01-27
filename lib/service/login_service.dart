import 'dart:convert';

import 'package:challange_mobile/service/api_endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future login(String nik, String password) async {
    print('Login Serivice');
    var response = await http.post(Uri.parse('$baseUrl/login'),
      // headers: {
      //   'Accept': '*/*',
      //   'Content-Type' : 'application/json',
      // },
      body: {
        "nik": nik,
        "password": password,
      },
    );

    debugPrint("LOGIN RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }
}
